const nodemailer = require("nodemailer");

async function mail(to, subject, message) {
  let testAccount = await nodemailer.createTestAccount();

  const transporter = nodemailer.createTransport({
    host: "localhost",
    port: 1025,
    auth: {
      user: "project.1",
      pass: "secret.1",
    },
  });

  await transporter.sendMail({
    from: '"Maket App" <doNotReply@maket.com>',
    to: to,
    subject: "Recovery Code #" + subject,
    html: "<h1>" + message + "</h1>",
  });
  return true;
}

// mail("ephraim@ilunga.com", 123, "Hello").catch(console.error);

module.exports = mail;
