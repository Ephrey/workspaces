import 'package:flutter/material.dart';

class ScreenSize {
  double height;
  double width;

  ScreenSize({@required context}) {
    Size screenSize = MediaQuery.of(context).size;
    this.height = screenSize.height;
    this.width = screenSize.width;
  }
}
