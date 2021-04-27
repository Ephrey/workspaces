import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:maket/constants/colors.dart';
import 'package:maket/constants/enums.dart';
import 'package:maket/ui/widgets/buttons/sign_in_button.dart';

class WelcomeView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 50.0,
          horizontal: 30.0,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SignInButton(
              icon: FontAwesomeIcons.envelope,
              text: 'Sign In with Email',
              onPressed: () => print('Sing in with Email'),
            ),
            SizedBox(height: 30.0),
            SignInButton(
              icon: FontAwesomeIcons.google,
              text: 'Sign In with Google',
              buttonType: ButtonType.secondary,
              onPressed: () => print('Sing in with Google'),
            ),
            SizedBox(height: 30.0),
            SignInButton(
              icon: FontAwesomeIcons.facebook,
              text: 'Sign In with Facebook',
              onPressed: () => print('Sign in with FB'),
              iconPosition: Position.right,
            ),
            SizedBox(height: 30.0),
            SignInButton(
              // icon: FontAwesomeIcons.twitter,
              text: 'Sign In with Twitter',
              onPressed: () => print('Sing in with Twitter'),
              contentPosition: Position.center,
              buttonType: ButtonType.disable,
            ),
            SizedBox(height: 90.0),
            RichText(
              text: TextSpan(
                text: 'Don\'t have an account ? ',
                style: TextStyle(
                  color: kPrimaryColor,
                  fontSize: 15.0,
                ),
                children: [
                  TextSpan(
                    text: 'Create.',
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      decoration: TextDecoration.underline,
                    ),
                    recognizer: TapGestureRecognizer()
                      ..onTap = () => print('Create'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
