import 'package:flutter/material.dart';
import 'package:maket/constants/colors.dart';
import 'package:maket/utils/time.dart';

const String kAppName = 'Makèt';

const String kAppSlogan = 'Shopping Made Easy';

const double kDefaultActionButtonHeight = 69.0;
const BorderSide kFocusedInputBorder =
    BorderSide(color: kPrimaryColor, width: 0.7);

const double kFloatingContainerBorderRadius = 10.0;
const double kLetterSpacing = 0.5;

const double kTextHeight = 1.6;

const Duration kOneYearDuration = Duration(days: Time.oneYear);

const String kTextButtonLogin = 'Log In';
const String kTextButtonRegister = 'Register';
const String kTextButtonNext = 'Next';
const String kTextButtonDone = 'Done';
const String kTextCreateItems = 'Create Items';
const String kTextCreateLists = 'Add a List';

const String kEmptyListItemsWarningMessage =
    'You have no Items to add to this list. '
    'Next create items and add them later.';

const String kTitleTextEmptyShoppingLists =
    'Your Shopping Lists will \n appear here.';

const String kSubTitleTextEmptyShoppingLists = 'To create Lists or Items, '
    'click either of the buttons below.';

const String kTitleTextNoItemsForList = 'Your Shopping List is empty';
const String kSubTitleTextNoItemsForList = 'Click "Add Item" button below '
    'to add items to this list.';

const String kOnErrorReloadMessage = 'Ooops Sorry !';
const String kOnErrorReloadSubMessage = 'Close and'
    'Reopen the App then try again.';

const kDeleteListWarningText = 'This action is irreversible. '
    'All selected Shopping Lists will be deleted.';

const TextStyle kCreateListAndItemsButtonStyle = TextStyle(
  color: kTextActionColor,
  fontWeight: FontWeight.w900,
  fontSize: 17.0,
  letterSpacing: kLetterSpacing,
);
