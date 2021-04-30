import 'package:flutter/material.dart';
import 'package:maket/constants/colors.dart';
import 'package:maket/ui/widgets/separator.dart';
import 'package:maket/utils/math.dart';
import 'package:maket/utils/numbers.dart';
import 'package:maket/utils/screen_size.dart';

class FormInput extends StatelessWidget {
  final String label;
  final bool password;
  final TextInputType keyBorderType;

  FormInput({
    this.label,
    this.password: false,
    this.keyBorderType: TextInputType.text,
  });

  @override
  Widget build(BuildContext context) {
    double _screenWidth = ScreenSize(context: context).width;

    double _textFieldPadding =
        (Math.percentage(percent: Numbers.five, total: _screenWidth) -
            Numbers.one);

    double _textSize =
        (Math.percentage(percent: Numbers.fore, total: _screenWidth) -
            Numbers.one);

    TextStyle _textStyle = TextStyle(
      color: kPrimaryColor,
      fontSize: _textFieldPadding,
      fontWeight: FontWeight.w600,
    );

    OutlineInputBorder _borderStyle = OutlineInputBorder(
      borderRadius: BorderRadius.zero,
      borderSide: BorderSide(
        color: kTextSecondaryColor,
      ),
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: _textStyle),
        Separator(distanceAsPercent: Numbers.one),
        TextFormField(
          keyboardType: keyBorderType,
          obscureText: password,
          style: TextStyle(
            color: kPrimaryColor,
            fontSize: _textSize,
          ),
          cursorColor: kPrimaryColor,
          textCapitalization: TextCapitalization.words,
          decoration: InputDecoration(
            hintText: 'Type in your $label',
            hintStyle: TextStyle(
              fontSize: _textSize,
              color: kTextSecondaryColor,
            ),
            contentPadding: EdgeInsets.symmetric(
              vertical: _textFieldPadding,
              horizontal: _textFieldPadding,
            ),
            border: _borderStyle,
            disabledBorder: _borderStyle,
            enabledBorder: _borderStyle,
            focusedBorder: _borderStyle.copyWith(
              borderSide: const BorderSide(color: kPrimaryColor, width: 0.7),
            ),
          ),
        ),
      ],
    );
  }
}
