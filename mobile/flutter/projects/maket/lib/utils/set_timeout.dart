import 'package:flutter/material.dart';
import 'package:maket/utils/numbers.dart';

void setTimeOut({@required Function callback, int seconds: Numbers.two}) {
  Future.delayed(Duration(seconds: seconds), callback);
}
