import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:maket/constants/colors.dart';
import 'package:maket/constants/enums.dart';
import 'package:maket/ui/widgets/separator.dart';
import 'package:maket/utils/numbers.dart';

class SuccessMessage extends StatelessWidget {
  final String message;
  final MessageType messageType;

  SuccessMessage({
    @required this.message,
    this.messageType: MessageType.success,
  }) : assert(message != null);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(
          FontAwesomeIcons.check,
          size: 120.0,
          color: kSuccessColor,
        ),
        Separator(distanceAsPercent: Numbers.two),
        Text(
          'Success',
          style: TextStyle(
            color: kPrimaryColor,
            fontSize: 35.0,
            fontWeight: FontWeight.w800,
          ),
        ),
        Separator(distanceAsPercent: Numbers.one),
        Text(
          message,
          style: TextStyle(
            color: kTextSecondaryColor,
            fontSize: Numbers.eighteen.toDouble(),
            fontWeight: FontWeight.w600,
          ),
        ),
        Separator(),
      ],
    );
  }
}
