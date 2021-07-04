const nodemailer = require("nodemailer");

class Email {
  transporter;

  constructor(from, to, subject, content) {
    this.to = to;
    this.from = from;
    this.subject = subject;
    this.content = content;
  }

  async send() {
    return await this.transporter.sendMail({
      from: this.from,
      to: this.to,
      subject: this.subject,
      html: this.content,
    });
  }

  async initTransport(
    host = "localhost",
    port = 1025,
    user = "project.1",
    pass = "secret.1"
  ) {
    this.transporter = nodemailer.createTransport({
      host,
      port,
      auth: { user, pass },
    });
    return true;
  }

  async initTestAccount() {
    return await nodemailer.createTestAccount();
  }
}

module.exports = Email;
