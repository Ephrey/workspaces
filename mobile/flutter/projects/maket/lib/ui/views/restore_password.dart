import 'package:flutter/material.dart';
import 'package:maket/constants/enums.dart';
import 'package:maket/ui/views/base/base_view.dart';
import 'package:maket/ui/views/base/centered_view.dart';
import 'package:maket/ui/views/base/padding_view.dart';
import 'package:maket/ui/views/base/scrollable_view.dart';
import 'package:maket/ui/widgets/buttons/action_button.dart';
import 'package:maket/ui/widgets/fields/form_field.dart';
import 'package:maket/ui/widgets/nav_bar.dart';
import 'package:maket/ui/widgets/separator.dart';
import 'package:maket/utils/numbers.dart';

class RestorePassword extends StatefulWidget {
  @override
  _RestorePasswordState createState() => _RestorePasswordState();
}

class _RestorePasswordState extends State<RestorePassword> {
  String _currentView = 'email';

  _setState(String view) {
    setState(() {
      _currentView = view;
    });
  }

  String _getButtonText() {
    if (_currentView == 'email') {
      return 'Next';
    } else if (_currentView == 'c_code') {
      return 'Submit';
    } else if (_currentView == 'pwd') {
      return 'Reset';
    }
  }

  @override
  Widget build(BuildContext context) {
    return BaseView(
      child: PaddingView(
        vertical: 0.0,
        child: Column(
          children: [
            NavBar(),
            Expanded(
              flex: 2,
              child: CenteredView(
                child: ScrollableView(
                  child: Form(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (_currentView == 'email')
                          FormInput(
                            label: 'Email',
                            keyBorderType: TextInputType.emailAddress,
                            autoFocus: true,
                            textAlign: TextAlign.center,
                          ),
                        if (_currentView == 'c_code')
                          FormInput(
                            hintText: 'Enter Confirmation Code',
                            keyBorderType: TextInputType.number,
                            autoFocus: true,
                            textAlign: TextAlign.center,
                          ),
                        if (_currentView == 'pwd')
                          FormInput(
                            hintText: 'Enter New Password',
                            autoFocus: true,
                            password: true,
                            textAlign: TextAlign.center,
                          ),
                        if (_currentView == 'pwd')
                          FormInput(
                            hintText: 'Confirm New Password',
                            password: true,
                            textAlign: TextAlign.center,
                          ),
                        Separator(distanceAsPercent: Numbers.three),
                        ActionButton(
                          text: _getButtonText(),
                          // buttonType: ButtonType.disable,
                          onPressed: () {
                            if (_currentView == 'email') {
                              _setState('c_code');
                            } else if (_currentView == 'c_code') {
                              print(_currentView);
                              _setState('pwd');
                            } else {
                              _setState('email');
                            }
                          },
                          iconPosition: Position.right,
                          contentPosition: Position.center,
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
