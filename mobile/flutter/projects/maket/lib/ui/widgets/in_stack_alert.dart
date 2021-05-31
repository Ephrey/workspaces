import 'package:flutter/material.dart';
import 'package:maket/constants/colors.dart';
import 'package:maket/constants/enums.dart';

class InStackAlert extends StatelessWidget {
  final String message;
  final Status messageType;

  InStackAlert({
    @required this.message,
    this.messageType: Status.success,
  }) : assert(message != null);

  @override
  Widget build(BuildContext context) {
    TextStyle _style = TextStyle(
      color: kBgPrimaryColor,
      fontSize: 15.0,
      fontWeight: FontWeight.w800,
    );

    return Container(
      padding: EdgeInsets.all(15.0),
      alignment: Alignment.center,
      child: Text(message, textAlign: TextAlign.center, style: _style),
      decoration: BoxDecoration(
        color: getStatusColor(messageType),
        borderRadius: BorderRadius.circular(5.0),
      ),
    );
  }
}
