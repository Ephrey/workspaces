import 'package:flutter/material.dart';
import 'package:maket/constants/enums.dart';
import 'package:maket/ui/views/base/base_view.dart';
import 'package:maket/ui/views/base/centered_view.dart';
import 'package:maket/ui/views/base/expanded_view.dart';
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

class RegisterView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BaseView(
      child: PaddingView(
        child: _RegisterViewBody(),
      ),
    );
  }
}

class _RegisterViewBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        NavBar(),
        ExpandedView(
          flex: 2,
          child: CenteredView(
            child: ScrollableView(child: _RegisterForm()),
          ),
        ),
      ],
    );
  }
}

class _RegisterForm extends StatefulWidget {
  @override
  _RegisterFormState createState() => _RegisterFormState();
}

class _RegisterFormState extends State<_RegisterForm> {
  final GlobalKey<FormState> _registerFormKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _registerFormKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          FormInput(label: 'Name'),
          Separator(distanceAsPercent: Numbers.three),
          FormInput(
            label: 'Email',
            keyBorderType: TextInputType.emailAddress,
          ),
          Separator(distanceAsPercent: Numbers.three),
          FormInput(label: 'Password', password: true),
          Separator(),
          CenteredView(
            child: TextRich(
              mainText: 'Have an account',
              richText: 'Sign In',
              onTap: () => print('Navigate to sign in view ...'),
            ),
          ),
          Separator(),
          ActionButton(
            buttonType: ButtonType.disable,
            text: 'Create',
            onPressed: () => print('creating account ... '),
            contentPosition: Position.center,
          ),
          Separator(),
          ContinueWithText(),
          Separator(),
          SocialNetworkIcons()
        ],
      ),
    );
  }
}
