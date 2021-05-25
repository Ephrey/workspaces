import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void hideSnackBar({BuildContext context}) {
  ScaffoldMessenger.of(context).removeCurrentSnackBar();
}
