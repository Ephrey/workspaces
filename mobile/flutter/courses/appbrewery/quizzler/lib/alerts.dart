import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class Alerts {
  static void show(BuildContext context) {
    Alert(
      context: context,
      type: AlertType.success,
      title: "Congrats !",
      desc: "You've completed the Quiz.",
      buttons: [
        DialogButton(
          child: Text(
            "RESTART",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          onPressed: () => Navigator.pop(context),
          width: 120,
        )
      ],
    ).show();
  }
}
