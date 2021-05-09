import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:maket/constants/colors.dart';

final ThemeData theme = ThemeData.light().copyWith(
  errorColor: kErrorColor,
  textTheme: GoogleFonts.openSansTextTheme(),
  scaffoldBackgroundColor: kBgPrimaryColor,
  snackBarTheme: SnackBarThemeData(
    backgroundColor: kPrimaryColor,
    contentTextStyle: TextStyle(color: kTextPrimaryColor),
  ),
);
