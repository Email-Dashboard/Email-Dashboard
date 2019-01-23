package mailer

import (
	"crypto/rand"
	"crypto/tls"
	"fmt"
	"math"
	"math/big"
	"os"
	"time"

	"Email-Dashboard/go-api-worker/models"

	"github.com/aymerick/raymond"
	gomail "gopkg.in/gomail.v2"
)

type mailOptions struct {
	emailFrom    string
	emailTo      []string
	emailCc      []string
	emailBcc     []string
	emailReplyTo []string
	subject      string
	content      string
}

type error interface {
	Error() string
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

	mid, err := deliverEmail(options, smtpOpt)
	if err != nil {
		models.GetDB().Model(&activity).Updates(models.Activity{Status: "fail", ErrorMessage: err.Error()})
	} else {
		models.GetDB().Model(&activity).Updates(models.Activity{Status: "success", MessageHeaderID: mid})
	}
}

// SendEmailToTestAccount email for test
func SendEmailToTestAccount(emailTo string, activity models.Activity, data models.RawContent, template models.NotificationContent, smtpOpt models.SMTPSetting) {
	var options mailOptions

	options.emailFrom = data.Email.From
	options.emailTo = []string{emailTo}

	parsedSubject := raymond.MustParse(template.Subject)
	options.subject = parsedSubject.MustExec(data.Variables)

	parsedContent := raymond.MustParse(template.Content)
	options.content = parsedContent.MustExec(data.Variables)

	mid, err := deliverEmail(options, smtpOpt)
	if err != nil {
		models.GetDB().Model(&activity).Updates(models.Activity{Status: "fail", ErrorMessage: err.Error()})
	} else {
		models.GetDB().Model(&activity).Updates(models.Activity{Status: "success", MessageHeaderID: mid, ErrorMessage: ("Sent to test account! " + emailTo)})
	}
}

// deliverEmail a private function to deliver smtp emails
func deliverEmail(options mailOptions, smtpOpt models.SMTPSetting) (mid string, err error) {

	messageID, _ := generateMessageID()

	m := gomail.NewMessage()
	m.SetHeader("From", options.emailFrom)
	m.SetHeader("To", options.emailTo...)
	m.SetHeader("Cc", options.emailCc...)
	m.SetHeader("Bcc", options.emailBcc...)
	m.SetHeader("Reply-To", options.emailReplyTo...)

	m.SetHeader("Message-Id", messageID)
	m.SetHeader("Subject", options.subject)
	m.SetBody("text/html", options.content)

	d := gomail.NewDialer(smtpOpt.Address, smtpOpt.Port, smtpOpt.Username, smtpOpt.Password)
	d.TLSConfig = &tls.Config{InsecureSkipVerify: true}

	// Send the email to receivers
	if err := d.DialAndSend(m); err != nil {
		return "", err
	}
	return messageID, nil
}

var maxBigInt = big.NewInt(math.MaxInt64)

// generateMessageID generates and returns a string suitable for an RFC 2822
// compliant Message-ID, e.g.: <1444789264909237300.3464.1819418242800517193@DESKTOP01>
func generateMessageID() (string, error) {
	t := time.Now().UnixNano()
	pid := os.Getpid()
	rint, err := rand.Int(rand.Reader, maxBigInt)
	if err != nil {
		return "", err
	}
	h, err := os.Hostname()
	// If we can't get the hostname, we'll use localhost
	if err != nil {
		h = "localhost.localdomain"
	}
	msgid := fmt.Sprintf("<%d.%d.%d@%s>", t, pid, rint, h)
	return msgid, nil
}
