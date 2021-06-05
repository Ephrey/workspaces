import 'package:flutter/material.dart';
import 'package:maket/constants/colors.dart';
import 'package:maket/utils/time.dart';

const double kDefaultActionButtonHeight = 69.0;
const BorderSide kFocusedInputBorder =
    BorderSide(color: kPrimaryColor, width: 0.7);

const double kFloatingContainerBorderRadius = 10.0;
const double kLetterSpacing = 0.5;

const Duration kOneYearDuration = Duration(days: Time.oneYear);

const String kTextButtonLogin = 'Log In';
const String kTextButtonRegister = 'Register';
const String kTextButtonNext = 'Next';
const String kTextButtonDone = 'Done';
const String kTextCreateItems = 'Create Items';
const String kTextCreateLists = 'Add a List';

const String kEmptyListWarningMessage =
    'You have no Items to add to this list. '
    'Next create items and add them later.';

const TextStyle kCreateListAndItemsButtonStyle = TextStyle(
  color: kTextActionColor,
  fontWeight: FontWeight.w900,
  fontSize: 17.0,
  letterSpacing: kLetterSpacing,
);
