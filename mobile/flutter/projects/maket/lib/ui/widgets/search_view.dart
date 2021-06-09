import 'package:flutter/material.dart';
import 'package:maket/constants/colors.dart';
import 'package:maket/ui/views/base/padding_view.dart';
import 'package:maket/ui/widgets/fields/form_field.dart';

class SearchView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 62.0,
      decoration: BoxDecoration(color: kBgPrimaryColor),
      child: PaddingView(
        child: FormInput(
          hintText: 'Search for an Item',
          prefixIcon: Icons.search,
          textAlign: TextAlign.center,
          withBorder: false,
        ),
      ),
    );
  }
}
