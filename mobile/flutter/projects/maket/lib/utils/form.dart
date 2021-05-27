import 'package:maket/utils/numbers.dart';

class Forms {
  static const String userNameField = 'username';
  static const String emailField = 'email';
  static const String password = 'password';

  static const int usernameMinLength = Numbers.three;
  static const int usernameMaxLength = Numbers.fifty;

  static const int passwordMinLength = Numbers.eight;
  static const int passwordMaxLength = Numbers.fifty;

  static const int itemNameMinLength = Numbers.two;
  static const int itemNameMaxLength = Numbers.twenty;

  static const int listNameMinLength = Numbers.three;
  static const int listNameMaxLength = Numbers.seventy;

  static const int listDescriptionMinLength = Numbers.five;
  static const int listDescriptionMaxLength = Numbers.eighty;
}
