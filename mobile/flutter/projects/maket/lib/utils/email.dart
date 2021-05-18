class Email {
  static const String regex =
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+";

  static bool isValid(String email) {
    return RegExp(regex).hasMatch(email);
  }
}
