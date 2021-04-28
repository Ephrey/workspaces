import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:maket/ui/views/base/centered_view.dart';

class Register extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BaseView(
      child: _RegisterBody(),
    );
  }
}

class _RegisterBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          child: Icon(FontAwesomeIcons.chevronLeft),
          height: 40.0,
        ),
        Expanded(
          flex: 2,
          child: SingleChildScrollView(
            child: Text(
              'Hello, world',
              style: TextStyle(fontSize: 700.0),
            ),
          ),
        ),
      ],
    );
  }
}
