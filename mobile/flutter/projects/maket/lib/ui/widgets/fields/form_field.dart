import 'package:flutter/material.dart';
import 'package:maket/constants/colors.dart';
import 'package:maket/constants/constants.dart';
import 'package:maket/constants/enums.dart';
import 'package:maket/ui/widgets/separator.dart';
import 'package:maket/utils/math.dart';
import 'package:maket/utils/numbers.dart';
import 'package:maket/utils/screen_size.dart';

class FormInput extends StatelessWidget {
  final InputType inputType;
  final String label;
  final bool password;
  final String hintText;
  final List items;
  final TextInputType keyBorderType;

  FormInput({
    this.inputType: InputType.field,
    this.label,
    this.password: false,
    this.hintText,
    this.items,
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

    TextStyle _labelTextStyle = TextStyle(
      color: kPrimaryColor,
      fontSize: _textFieldPadding,
      fontWeight: FontWeight.w600,
    );

    OutlineInputBorder _borderStyle = OutlineInputBorder(
      borderRadius: BorderRadius.zero,
      borderSide: BorderSide(color: kTextSecondaryColor),
    );

    InputDecoration _inputDecoration = InputDecoration(
      hintText: (hintText != null) ? hintText : 'Type in your $label',
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
        borderSide: kFocusedInputBorder,
      ),
    );

    TextStyle _inputTexStyle = TextStyle(
      color: kPrimaryColor,
      fontSize: _textSize,
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: _labelTextStyle),
        Separator(distanceAsPercent: Numbers.one),
        (inputType == InputType.field)
            ? _TextFormField(
                keyBorderType: keyBorderType,
                password: password,
                inputTextStyle: _inputTexStyle,
                inputDecoration: _inputDecoration,
              )
            : _DropdownFormField(
                items: items,
                inputTextStyle: _inputTexStyle,
                inputDecoration: _inputDecoration,
              ),
      ],
    );
  }
}

class _DropdownFormField extends StatelessWidget {
  final List items;
  final InputDecoration inputDecoration;
  final TextStyle inputTextStyle;
  final Function onChanged;

  const _DropdownFormField({
    this.items,
    this.inputDecoration,
    this.inputTextStyle,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField(
      icon: const Icon(Icons.keyboard_arrow_down),
      iconSize: Math.percentage(
          percent: Numbers.six, total: ScreenSize(context: context).width),
      isExpanded: true,
      style: inputTextStyle,
      items: items.map<DropdownMenuItem>((value) {
        return DropdownMenuItem<String>(
          child: Text(value),
          value: value,
        );
      }).toList(),
      onChanged: (newValue) => print(newValue),
      decoration: inputDecoration,
    );
  }
}

class _TextFormField extends StatelessWidget {
  final TextInputType keyBorderType;
  final bool password;
  final TextStyle inputTextStyle;
  final InputDecoration inputDecoration;

  const _TextFormField({
    this.keyBorderType,
    this.password,
    this.inputTextStyle,
    this.inputDecoration,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: keyBorderType,
      obscureText: password,
      style: inputTextStyle,
      cursorColor: kPrimaryColor,
      textCapitalization: TextCapitalization.words,
      decoration: inputDecoration,
    );
  }
}
