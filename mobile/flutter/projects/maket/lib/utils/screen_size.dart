import 'package:flutter/material.dart';

class ScreenSize {
  double height;
  double width;

  ScreenSize({@required context}) {
    Size screenSize = MediaQuery.of(context).size;
    this.height =
        screenSize.height < 570 ? (screenSize.height + 200) : screenSize.height;
    this.width =
        screenSize.width <= 320 ? (screenSize.width + 100) : screenSize.width;
  }
}
