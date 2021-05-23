import 'package:flutter/material.dart';
import 'package:maket/config/routes/router.dart';
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
import 'package:maket/utils/navigation/push.dart';
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

  TextEditingController _emailController;
  TextEditingController _passwordController;

  Status _emailState;
  Status _passwordStatus;

  void _handleEmailField(String email) {
    print(email);
  }

  void _handlePasswordField(String password) {
    print(password);
  }

  void _setState(callback) {
    setState(callback);
  }

  @override
  void initState() {
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

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
            autoFocus: true,
            controller: _emailController,
            onChange: _handleEmailField,
            capitalization: TextCapitalization.none,
          ),
          Separator(distanceAsPercent: Numbers.three),
          FormInput(
            label: 'Password',
            password: true,
            controller: _passwordController,
            onChange: _handlePasswordField,
          ),
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
              onTap: () => pushRoute(
                context: context,
                name: AppRoute.registerView,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
