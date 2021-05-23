import 'package:flutter/material.dart';
import 'package:maket/constants/enums.dart';

const Color kPrimaryColor = Color(0xFF0E0E10);
const Color kSecondaryColor = Color(0xFFF3F6FA);

const Color kTextPrimaryColor = Color(0xFFFAF1E6);
const Color kTextSecondaryColor = Color(0xFFA0A2A4);

const Color kSuccessColor = Color(0xFF16C79A);
const Color kWarningColor = Color(0xFFFFCC61);
const Color kErrorColor = Color(0xFFFB3640);

const Color kBgPrimaryColor = Color(0xFFFAFAFA);
const Color kBgSecondaryColor = Color(0xFFF7F7F7);

const Color kElevationColor = Color(0xFFEAEAEA);

const Color kWhite = Color(0xFFFFFFFF);

const Color kTransparentColor = Colors.transparent;

Color getStatusColor(Status state) {
  switch (state) {
    case Status.success:
      return kSuccessColor;
    case Status.warning:
      return kWarningColor;
    case Status.error:
      return kErrorColor;
    case Status.normal:
    default:
      return kPrimaryColor;
  }
}
