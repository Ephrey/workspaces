import 'package:flutter/material.dart';
import 'package:maket/utils/numbers.dart';

void setTimeOut({@required Function callback, int waitingSecond: Numbers.two}) {
  Future.delayed(Duration(seconds: waitingSecond), callback);
}
