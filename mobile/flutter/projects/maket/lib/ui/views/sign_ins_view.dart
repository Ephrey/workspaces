import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:maket/constants/enums.dart';
import 'package:maket/ui/views/base/base_view.dart';
import 'package:maket/ui/views/base/padding_view.dart';
import 'package:maket/ui/widgets/buttons/action_button.dart';
import 'package:maket/ui/widgets/separator.dart';
import 'package:maket/ui/widgets/texts/rich_text.dart';
import 'package:maket/utils/numbers.dart';

class SignInsView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BaseView(
      child: PaddingView(child: _SignInsViewBody()),
      centered: true,
    );
  }
}

class _SignInsViewBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        ActionButton(
          icon: FontAwesomeIcons.at,
          text: 'Sign In with Email',
          onPressed: () => print('Sing in with Email'),
        ),
        Separator(),
        ActionButton(
          icon: FontAwesomeIcons.google,
          text: 'Sign In with Google',
          buttonType: ButtonType.secondary,
          onPressed: () => print('Sing in with Google'),
        ),
        Separator(),
        ActionButton(
          icon: FontAwesomeIcons.facebook,
          text: 'Sign In with Facebook',
          buttonType: ButtonType.secondary,
          onPressed: () => print('Sign in with FB'),
        ),
        Separator(),
        ActionButton(
          icon: FontAwesomeIcons.twitter,
          text: 'Sign In with Twitter',
          buttonType: ButtonType.secondary,
          onPressed: () => print('Sing in with Twitter'),
        ),
        Separator(distanceAsPercent: Numbers.six),
        TextRich(
          mainText: 'Don\' have an account',
          richText: 'Create',
          onTap: () => print('Go create account ...'),
        )
      ],
    );
  }
}
