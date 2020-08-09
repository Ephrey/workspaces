import 'package:flutter/material.dart';
import 'package:todo/common/colors.dart';

final theme = ThemeData(
  primaryColor: kPrimary,
  accentColor: kPrimary,
  cardColor: kWhite,
  textTheme: TextTheme(
    headline1: TextStyle(
      color: kWhite,
      fontSize: 20.0,
      fontWeight: FontWeight.bold,
    ),
    headline2: TextStyle(
      fontSize: 17.0,
      height: 1.5,
    ),
    headline4: TextStyle(
      fontSize: 20.0,
      fontWeight: FontWeight.bold,
      color: kWhite,
    ),
    headline5: TextStyle(
      fontSize: 35.0,
      fontWeight: FontWeight.w700,
    ),
    headline6: TextStyle(
      color: kWhite,
      fontSize: 15.0,
    ),
  ),
);
