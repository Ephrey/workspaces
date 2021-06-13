import 'package:flutter/material.dart';
import 'package:maket/ui/widgets/fields/form_field.dart';

class SearchInput extends StatelessWidget {
  final String hintText;
  final TextEditingController controller;
  final Function onChange;

  SearchInput({this.hintText, this.onChange, this.controller});

  @override
  Widget build(BuildContext context) {
    return FormInput(
      controller: controller,
      hintText: hintText,
      prefixIcon: Icons.search,
      textAlign: TextAlign.center,
      withBorder: false,
      onChange: onChange,
    );
  }
}
