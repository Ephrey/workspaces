import 'package:flutter/material.dart';
import 'package:maket/constants/enums.dart';
import 'package:maket/ui/views/base/base_view.dart';
import 'package:maket/ui/views/base/centered_view.dart';
import 'package:maket/ui/views/base/padding_view.dart';
import 'package:maket/ui/views/base/scrollable_view.dart';
import 'package:maket/ui/widgets/buttons/action_button.dart';
import 'package:maket/ui/widgets/continue_with_text.dart';
import 'package:maket/ui/widgets/fields/form_field.dart';
import 'package:maket/ui/widgets/nav_bar.dart';
import 'package:maket/ui/widgets/separator.dart';
import 'package:maket/ui/widgets/social_network_icons.dart';
import 'package:maket/ui/widgets/texts/rich_text.dart';
import 'package:maket/utils/numbers.dart';

class SignInView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BaseView(
      child: PaddingView(
        child: _SignInViewBody(),
      ),
    );
  }
}

class _SignInViewBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        NavBar(),
        Expanded(
          flex: 2,
          child: CenteredView(
            child: ScrollableView(
              child: _SignInForm(),
            ),
          ),
        ),
      ],
    );
  }
}

class _SignInForm extends StatefulWidget {
  @override
  _SignInFormState createState() => _SignInFormState();
}

class _SignInFormState extends State<_SignInForm> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          FormInput(
            label: 'Email',
            keyBorderType: TextInputType.emailAddress,
          ),
          Separator(distanceAsPercent: Numbers.three),
          FormInput(label: 'Password', password: true),
          Separator(),
          CenteredView(
            child: TextRich(
              mainText: 'Forgot password',
              richText: 'Restore',
              onTap: () => print('Navigate to Restoring view ...'),
            ),
          ),
          Separator(),
          ActionButton(
            buttonType: ButtonType.disable,
            text: 'Sign In',
            onPressed: () => print('Signing In... '),
            contentPosition: Position.center,
          ),
          Separator(),
          ContinueWithText(),
          Separator(),
          SocialNetworkIcons(),
          Separator(distanceAsPercent: Numbers.six),
          CenteredView(
            child: TextRich(
              mainText: 'Don\'t have an account',
              richText: 'Create',
              onTap: () => print('Navigate to Register ...'),
            ),
          ),
        ],
      ),
    );
  }
}
