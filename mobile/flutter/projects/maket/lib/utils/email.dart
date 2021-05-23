class Email {
  static const String _regex =
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+";

  static bool isValid({String email}) {
    return RegExp(_regex).hasMatch(email);
  }
}
