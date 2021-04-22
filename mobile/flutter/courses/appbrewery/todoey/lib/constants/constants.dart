import 'package:flutter/material.dart';

const UnderlineInputBorder kUnderlineInputBorder = UnderlineInputBorder(
  borderSide: BorderSide(color: Colors.lightBlueAccent, width: 5.0),
);

final InputDecoration kInputDecoration = InputDecoration(
  enabledBorder: kUnderlineInputBorder,
  focusedBorder: kUnderlineInputBorder,
);
