import 'package:flutter/material.dart';

class CustomFormField extends StatelessWidget {
  final controller;
  final String hint;
  final bool isRequired;
  final String errorMessage;
  final int maxLines;

  CustomFormField({
    Key key,
    @required this.controller,
    @required this.hint,
    this.isRequired: false,
    this.errorMessage: 'This field is required',
    this.maxLines: 1,
  });

  String _validator(value) {
    return value.trim().replaceAll(r" ", ' ').isEmpty ? errorMessage : null;
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(hintText: hint),
      validator: isRequired ? _validator : null,
      maxLines: maxLines,
    );
  }
}
