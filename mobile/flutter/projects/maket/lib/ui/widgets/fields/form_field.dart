import 'package:flutter/material.dart';
import 'package:maket/constants/colors.dart';
import 'package:maket/constants/common.dart';
import 'package:maket/constants/enums.dart';
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
  final Widget suffixIcon;
  final TextAlign textAlign;
  final bool withBorder;
  final TextCapitalization capitalization;
  final bool autoFocus;
  final Function onChange;
  final Status state;
  final dynamic selectedValue;

  FormInput({
    this.controller,
    this.inputType: InputType.field,
    this.label,
    this.password: false,
    this.hintText,
    this.items,
    this.keyBorderType: TextInputType.text,
    this.minLines: Numbers.one,
    this.maxLines: Numbers.six,
    this.prefixIcon,
    this.suffixIcon,
    this.textAlign: TextAlign.start,
    this.capitalization: TextCapitalization.words,
    this.withBorder: true,
    this.autoFocus: false,
    this.onChange,
    this.state,
    this.selectedValue,
  });

  @override
  Widget build(BuildContext context) {
    double _textFieldPadding = Numbers.size(
          context: context,
          percent: Numbers.five,
          dimension: Dimension.width,
        ) -
        Numbers.one;

    double _textSize = Numbers.size(
          context: context,
          percent: Numbers.four,
          dimension: Dimension.width,
        ) -
        Numbers.one;

    // TextStyle _labelTextStyle = TextStyle(
    //   color: kPrimaryColor,
    //   fontSize: _textFieldPadding,
    //   fontWeight: FontWeight.w600,
    // );

    UnderlineInputBorder _borderStyle = UnderlineInputBorder(
      borderRadius: BorderRadius.zero,
      borderSide: BorderSide(
        color: (withBorder) ? kTextSecondaryColor : kTransparentColor,
      ),
    );

    InputDecoration _inputDecoration = InputDecoration(
      suffixIcon: (suffixIcon != null) ? suffixIcon : null,
      prefixIcon: (prefixIcon != null)
          ? Icon(prefixIcon,
              size: Numbers.size(
                context: context,
                percent: Numbers.eight,
                dimension: Dimension.width,
              ),
              color: kTextSecondaryColor)
          : null,
      hintText: (hintText != null) ? hintText : 'Type in your $label',
      hintStyle: TextStyle(
        fontSize: _textSize,
        color: kTextSecondaryColor,
      ),
      contentPadding: EdgeInsets.symmetric(
        vertical: _textFieldPadding,
        // horizontal: _textFieldPadding,
      ),
      border: _borderStyle,
      disabledBorder: _borderStyle,
      enabledBorder: _borderStyle,
      focusedBorder: _borderStyle.copyWith(
        borderSide: kFocusedInputBorder,
      ),
    );

    TextStyle _inputTexStyle = TextStyle(
      color: (state == null) ? kPrimaryColor : getStatusColor(state),
      fontSize: _textSize,
      fontWeight: (state == Status.success) ? FontWeight.w800 : FontWeight.w500,
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
            onChange: onChange,
            capitalization: capitalization,
          );
        case InputType.dropdown:
          return _DropdownFormField(
            items: items,
            inputTextStyle: _inputTexStyle,
            inputDecoration: _inputDecoration,
            onChanged: onChange,
            selectedValue: selectedValue,
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
            capitalization: capitalization,
            onChange: onChange,
          );
        default:
          return _TextFormField();
      }
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // if (label != null) Text(label, style: _labelTextStyle),
        // if (label != null) Separator(distanceAsPercent: Numbers.one),
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
  final dynamic selectedValue;

  const _DropdownFormField({
    this.items,
    this.inputDecoration,
    this.inputTextStyle,
    this.onChanged,
    this.selectedValue,
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
          child: Text(
            value,
            style: TextStyle(
              color: (selectedValue == value) ? kSuccessColor : kPrimaryColor,
            ),
          ),
          value: value,
        );
      }).toList(),
      selectedItemBuilder: (selectedValue == '')
          ? null
          : (_) {
              return items.map((value) {
                return Text(
                  selectedValue,
                  style: const TextStyle(color: kSuccessColor),
                );
              }).toList();
            },
      onChanged: onChanged,
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
  final Function onChange;
  final Function validator;
  final TextCapitalization capitalization;

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
    this.capitalization,
    this.onChange,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: keyBorderType,
      obscureText: password,
      style: inputTextStyle,
      cursorColor: kPrimaryColor,
      textCapitalization: capitalization,
      decoration: inputDecoration,
      minLines: minLines,
      maxLines:
          (keyBorderType == TextInputType.multiline) ? maxLines : Numbers.one,
      textAlign: textAlign,
      autofocus: autoFocus,
      onChanged: onChange,
    );
  }
}
