class Response {
  static CODE_WRONG_EMAIL_OR_PASSWORD = 1;

  static TEXT_WRONG_EMAIL_OR_PASSWORD = "Invalid Email or Password";

  static build(status, code, message, data = {}) {
    return { status, code, message, data };
  }

  static translate(code) {}
}
