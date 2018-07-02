package mailer

import (
	"fmt"
	"net/smtp"

	"notification-center-go-api/models"

	"github.com/aymerick/raymond"
	"github.com/jordan-wright/email"
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

	options.emailTo = data.Email.To
	options.emailCc = data.Email.Cc
	options.emailBcc = data.Email.Bcc
	options.emailFrom = data.Email.From
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

// SendEmailToTest email for test
func SendEmailToTestAccount() {

}

// deliverEmail a private function to deliver smtp emails
func deliverEmail(options mailOptions, smtpOpt models.SMTPSetting) {
	e := email.NewEmail()
	e.From = options.emailFrom
	e.To = options.emailTo
	e.Bcc = options.emailBcc
	e.Cc = options.emailCc
	e.Subject = options.subject
	// e.Text = []byte("Text Body is, of course, supported!")
	e.HTML = []byte(options.content)

	e.Send(smtpOpt.Address+":"+smtpOpt.Port, smtp.PlainAuth("", smtpOpt.Username, smtpOpt.Password, smtpOpt.Address))

	fmt.Println(e)
}
