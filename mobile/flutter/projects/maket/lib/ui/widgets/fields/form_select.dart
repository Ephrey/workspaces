import 'package:flutter/material.dart';
import 'package:maket/constants/colors.dart';
import 'package:maket/ui/widgets/separator.dart';
import 'package:maket/utils/math.dart';
import 'package:maket/utils/numbers.dart';
import 'package:maket/utils/screen_size.dart';

class FormSelect extends StatelessWidget {
  final String label;
  final bool password;
  final TextInputType keyBorderType;

  FormSelect({
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
        (Math.percentage(percent: Numbers.four, total: _screenWidth) -
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
        DropdownButtonFormField(
          value: null,
          icon: Icon(Icons.keyboard_arrow_down),
          iconSize: 25,
          isExpanded: true,
          dropdownColor: kPrimaryColor,
          style: TextStyle(
            color: kPrimaryColor,
            fontSize: _textSize,
          ),
          items: <String>['One', 'Two', 'Free', 'Four']
              .map<DropdownMenuItem>((String value) {
            return DropdownMenuItem<String>(
              child: Text(value),
              value: value,
            );
          }).toList(),
          onChanged: (newValue) => print(newValue),
          decoration: InputDecoration(
            hintText: 'Select a category',
            hintStyle: TextStyle(
              fontSize: _textSize,
              color: kTextSecondaryColor,
            ),
            border: _borderStyle,
            focusedBorder: _borderStyle,
            enabledBorder: _borderStyle,
          ),
        ),
      ],
    );
  }
}
