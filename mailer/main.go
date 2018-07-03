package mailer

import (
	"crypto/tls"
	"fmt"

	"notification-center-go-api/models"

	"github.com/aymerick/raymond"

	"gopkg.in/gomail.v2"
)

type mailOptions struct {
	emailFrom    string
	emailTo      []string
	emailCc      []string
	emailBcc     []string
	emailReplyTo string
	subject      string
	content      string
}

// SendEmailToReceivers via smtp
func SendEmailToReceivers(activity models.Activity, data models.RawContent, template models.NotificationContent, smtpOpt models.SMTPSetting) {
	var options mailOptions

	options.emailFrom = data.Email.From
	options.emailTo = data.Email.To
	options.emailCc = data.Email.Cc
	options.emailBcc = data.Email.Bcc
	options.emailReplyTo = data.Email.ReplyTo

	parsedSubject := raymond.MustParse(template.Subject)
	options.subject = parsedSubject.MustExec(data.Variables)

	parsedContent := raymond.MustParse(template.Content)
	options.content = parsedContent.MustExec(data.Variables)

	for _, receiver := range data.Email.To {
		fmt.Println("create receiver: " + receiver)
	}

	deliverEmail(options, smtpOpt)
}

// SendEmailToTestAccount email for test
func SendEmailToTestAccount(emailTo string, activity models.Activity, data models.RawContent, template models.NotificationContent, smtpOpt models.SMTPSetting) {
	var options mailOptions

	options.emailFrom = data.Email.From
	options.emailTo[0] = emailTo

	parsedSubject := raymond.MustParse(template.Subject)
	options.subject = parsedSubject.MustExec(data.Variables)

	parsedContent := raymond.MustParse(template.Content)
	options.content = parsedContent.MustExec(data.Variables)

	err := deliverEmail(options, smtpOpt)

	if err != nil {
		// models.GetDB().Model(&activity).Updates(models.Activity{Status: "canceled", ErrorMessage: "Test Mode Account!"})
	}
}

// deliverEmail a private function to deliver smtp emails
func deliverEmail(options mailOptions, smtpOpt models.SMTPSetting) (err error) {

	m := gomail.NewMessage()
	m.SetHeader("From", options.emailFrom)
	m.SetHeader("To", options.emailTo...)
	m.SetHeader("Cc", options.emailCc...)
	m.SetHeader("Bcc", options.emailBcc...)
	m.SetHeader("Subject", options.subject)
	m.SetBody("text/html", options.content)

	d := gomail.NewDialer(smtpOpt.Address, smtpOpt.Port, smtpOpt.Username, smtpOpt.Password)
	d.TLSConfig = &tls.Config{InsecureSkipVerify: true}

	// Send the email to receivers
	if err := d.DialAndSend(m); err != nil {
		return err
	}
	return nil
}
