import 'package:flutter/material.dart';
import 'package:maket/config/routes/router.dart';
import 'package:maket/constants/enums.dart';
import 'package:maket/core/models/user_model.dart';
import 'package:maket/core/viewmodels/sign_in_viewmodel.dart';
import 'package:maket/ui/views/base/base_view.dart';
import 'package:maket/ui/views/base/centered_view.dart';
import 'package:maket/ui/views/base/padding_view.dart';
import 'package:maket/ui/views/base/scrollable_view.dart';
import 'package:maket/ui/widgets/buttons/action_button.dart';
import 'package:maket/ui/widgets/fields/form_field.dart';
import 'package:maket/ui/widgets/nav_bar.dart';
import 'package:maket/ui/widgets/separator.dart';
import 'package:maket/ui/widgets/snackbar_alert.dart';
import 'package:maket/ui/widgets/social_network_icons.dart';
import 'package:maket/ui/widgets/texts/continue_with_text.dart';
import 'package:maket/ui/widgets/texts/rich_text.dart';
import 'package:maket/utils/email.dart';
import 'package:maket/utils/form.dart';
import 'package:maket/utils/locator.dart';
import 'package:maket/utils/navigation/push.dart';
import 'package:maket/utils/numbers.dart';
import 'package:maket/utils/snackbar/show_snackbar.dart';
import 'package:provider/provider.dart';

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
              child: ChangeNotifierProvider(
                create: (context) => locator<SignInViewModel>(),
                child: _SignInForm(),
              ),
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
  TextEditingController _emailController;
  TextEditingController _passwordController;

  Status _emailState;
  Status _passwordState;

  bool _canSubmitForm = false;

  dynamic _handleEmailField(String email) {
    final _isValidEmail = Email.isValid(email: email);
    if (_isValidEmail && _emailState == Status.success) return false;

    _setState(() => _emailState = _getFieldState(_isValidEmail));
    _checkIfCanSubmitForm();
  }

  dynamic _handlePasswordField(String password) {
    final _passwordLength = password.length;

    final _isPasswordValid = (_passwordLength >= Forms.passwordMinLength &&
        _passwordLength <= Forms.passwordMaxLength);

    if (_isPasswordValid && (_passwordState == Status.success)) return false;

    _setState(() => _passwordState = _getFieldState(_isPasswordValid));
    _checkIfCanSubmitForm();
  }

  void _checkIfCanSubmitForm() {
    _setState(() => _canSubmitForm =
        (_emailState == Status.success && _passwordState == Status.success));
  }

  Status _getFieldState(bool state) {
    return (state) ? Status.success : Status.error;
  }

  void _handleSubmitForm({BuildContext context}) async {
    _canSubmitForm = false;

    final UserLogin useInfo = UserLogin(
      email: _emailController.text,
      password: _passwordController.text,
    );

    final _response =
        await context.read<SignInViewModel>().login(user: useInfo);

    if (_response.status) {
      return pushRoute(context: context, name: AppRoute.shoppingListsView);
    } else {
      _checkIfCanSubmitForm();

      return showSnackBar(
        context: context,
        content: SnackBarAlert(message: _response.message),
        flavor: Status.error,
      );
    }
  }

  void _setState(callback) => setState(callback);

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
            state: _emailState,
          ),
          Separator(distanceAsPercent: Numbers.three),
          FormInput(
            label: 'Password',
            password: true,
            controller: _passwordController,
            onChange: _handlePasswordField,
            state: _passwordState,
          ),
          Separator(),
          CenteredView(
            child: TextRich(
              mainText: 'Forgot password',
              richText: 'Restore',
              onTap: () =>
                  pushRoute(context: context, name: AppRoute.restorePassword),
            ),
          ),
          Separator(),
          ActionButton(
            buttonType:
                (_canSubmitForm) ? ButtonType.primary : ButtonType.disable,
            text: 'Sign In',
            onPressed: () => _handleSubmitForm(context: context),
            contentPosition: Position.center,
            loading: (context.watch<SignInViewModel>().state == ViewState.busy),
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
              onTap: () =>
                  pushRoute(context: context, name: AppRoute.registerView),
            ),
          ),
        ],
      ),
    );
  }
}
