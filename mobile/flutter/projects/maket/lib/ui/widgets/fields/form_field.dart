import 'package:flutter/material.dart';
import 'package:maket/constants/colors.dart';
import 'package:maket/constants/constants.dart';
import 'package:maket/constants/enums.dart';
import 'package:maket/ui/widgets/separator.dart';
import 'package:maket/utils/math.dart';
import 'package:maket/utils/numbers.dart';
import 'package:maket/utils/screen_size.dart';

class FormInput extends StatelessWidget {
  final TextEditingController controller;
  final InputType inputType;
  final String label;
  final bool password;
  final String hintText;
  final List items;
  final TextInputType keyBorderType;
  final int minLines;
  final int maxLines;
  final IconData prefixIcon;
  final TextAlign textAlign;
  final bool withBorder;
  final bool autoFocus;

  FormInput({
    @required this.controller,
    this.inputType: InputType.field,
    this.label,
    this.password: false,
    this.hintText,
    this.items,
    this.keyBorderType: TextInputType.text,
    this.minLines: Numbers.one,
    this.maxLines: Numbers.six,
    this.prefixIcon,
    this.textAlign: TextAlign.start,
    this.withBorder: true,
    this.autoFocus: false,
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
      borderSide: BorderSide(
        color: (withBorder) ? kTextSecondaryColor : kTransparentColor,
      ),
    );

    InputDecoration _inputDecoration = InputDecoration(
      prefixIcon: (prefixIcon != null)
          ? Icon(prefixIcon,
              size:
                  Math.percentage(percent: Numbers.eight, total: _screenWidth),
              color: kTextSecondaryColor)
          : null,
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

    Widget _getInput(InputType type) {
      switch (type) {
        case InputType.field:
          return _TextFormField(
            controller: controller,
            keyBorderType: keyBorderType,
            password: password,
            inputTextStyle: _inputTexStyle,
            inputDecoration: _inputDecoration,
            textAlign: textAlign,
            autoFocus: autoFocus,
          );
        case InputType.dropdown:
          return _DropdownFormField(
            items: items,
            inputTextStyle: _inputTexStyle,
            inputDecoration: _inputDecoration,
          );
        case InputType.textArea:
          return _TextFormField(
            controller: controller,
            keyBorderType: keyBorderType,
            inputTextStyle: _inputTexStyle,
            inputDecoration: _inputDecoration,
            minLines: minLines,
            maxLines: maxLines,
            password: password,
            textAlign: textAlign,
          );
        default:
          return _TextFormField();
      }
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (label != null) Text(label, style: _labelTextStyle),
        if (label != null) Separator(distanceAsPercent: Numbers.one),
        _getInput(inputType)
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
  final TextEditingController controller;
  final TextInputType keyBorderType;
  final bool password;
  final TextStyle inputTextStyle;
  final InputDecoration inputDecoration;
  final int minLines;
  final int maxLines;
  final TextAlign textAlign;
  final bool autoFocus;

  const _TextFormField({
    this.controller,
    this.keyBorderType,
    this.password,
    this.inputTextStyle,
    this.inputDecoration,
    this.minLines,
    this.maxLines,
    this.textAlign,
    this.autoFocus: false,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: keyBorderType,
      obscureText: password,
      style: inputTextStyle,
      cursorColor: kPrimaryColor,
      textCapitalization: TextCapitalization.words,
      decoration: inputDecoration,
      minLines: minLines,
      maxLines:
          (keyBorderType == TextInputType.multiline) ? maxLines : Numbers.one,
      textAlign: textAlign,
      autofocus: autoFocus,
      onChanged: (value) => print(value),
    );
  }
}
