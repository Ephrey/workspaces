class Response {
  CODE_WRONG_EMAIL_OR_PASSWORD = 1;

  TEXT_WRONG_EMAIL_OR_PASSWORD = "Invalid Email or Password";

  build(status, code, message, data = {}) {
    return { status, code, message, data };
  }

  translate(code) {}
}
