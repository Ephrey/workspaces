import 'package:flutter/material.dart';

class SnackBarAlert extends StatelessWidget {
  final String message;

  const SnackBarAlert({@required this.message}) : assert(message != null);

  @override
  Widget build(BuildContext context) {
    return Text(
      message,
      textAlign: TextAlign.center,
      style: TextStyle(fontSize: 17.0, fontWeight: FontWeight.w600),
    );
  }
}
