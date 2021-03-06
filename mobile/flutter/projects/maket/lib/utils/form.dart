import 'package:maket/utils/numbers.dart';

class Forms {
  Forms._();

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
  static const int listNameMaxLength = Numbers.forty;

  static const int minBudget = Numbers.zero;
  static const int maxBudget = Numbers.fiveHundredThousand;

  static const int listDescriptionMinLength = Numbers.five;
  static const int listDescriptionMaxLength = Numbers.hundred;

  static const double minItemPrice = 1.0;
  static const double maxItemPrice = 500000.00;
}
