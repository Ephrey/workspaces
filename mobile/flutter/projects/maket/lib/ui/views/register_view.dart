import 'package:flutter/material.dart';
import 'package:maket/config/routes/router.dart';
import 'package:maket/constants/enums.dart';
import 'package:maket/core/models/user_model.dart';
import 'package:maket/core/viewmodels/register_viewmodel.dart';
import 'package:maket/ui/views/base/base_view.dart';
import 'package:maket/ui/views/base/centered_view.dart';
import 'package:maket/ui/views/base/expanded_view.dart';
import 'package:maket/ui/views/base/padding_view.dart';
import 'package:maket/ui/views/base/scrollable_view.dart';
import 'package:maket/ui/widgets/buttons/action_button.dart';
import 'package:maket/ui/widgets/continue_with_text.dart';
import 'package:maket/ui/widgets/fields/form_field.dart';
import 'package:maket/ui/widgets/loading.dart';
import 'package:maket/ui/widgets/nav_bar.dart';
import 'package:maket/ui/widgets/separator.dart';
import 'package:maket/ui/widgets/social_network_icons.dart';
import 'package:maket/ui/widgets/texts/rich_text.dart';
import 'package:maket/utils/email.dart';
import 'package:maket/utils/form.dart';
import 'package:maket/utils/locator.dart';
import 'package:maket/utils/navigation/push.dart';
import 'package:maket/utils/numbers.dart';
import 'package:provider/provider.dart';

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
            child: ScrollableView(
              child: ChangeNotifierProvider(
                create: (context) => locator<RegisterViewModel>(),
                child: _RegisterForm(),
              ),
            ),
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

  TextEditingController _userNameController;
  TextEditingController _emailAddressController;
  TextEditingController _passwordController;

  ValidationState _userNameState;
  ValidationState _emailState;
  ValidationState _passwordState;

  bool _canSubmitForm = false;
  bool _busy = false;

  @override
  void initState() {
    _userNameController = TextEditingController();
    _emailAddressController = TextEditingController();
    _passwordController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _userNameController.dispose();
    _emailAddressController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _setState(dynamic value, [String field]) {
    setState(() {
      switch (field) {
        case Forms.userNameField:
          _userNameState = value;
          break;
        case Forms.emailField:
          _emailState = value;
          break;
        case Forms.password:
          _passwordState = value;
          break;
        default:
          _canSubmitForm = value;
      }
    });
  }

  _checkIfCanSubmitForm() {
    _setState(
      (_userNameState == ValidationState.success &&
          _emailState == ValidationState.success &&
          _passwordState == ValidationState.success),
    );
  }

  _handleNameFieldChange(String userName) {
    final int length = userName.length;
    final bool isUserNameValid =
        (length > Forms.usernameMinLength && length <= Forms.usernameMaxLength);

    if (isUserNameValid && _userNameState == ValidationState.success) {
      return false;
    }

    _setState(
      ((isUserNameValid) ? ValidationState.success : ValidationState.error),
      Forms.userNameField,
    );

    _checkIfCanSubmitForm();
  }

  _handleEmailFieldChange(String email) {
    final bool _isValid = Email.isValid(email);

    if (_isValid && _emailState == ValidationState.success) return false;

    _setState(
      (_isValid ? ValidationState.success : ValidationState.error),
      Forms.emailField,
    );
    _checkIfCanSubmitForm();
  }

  _handlePasswordFieldChange(dynamic password) {
    final int length = password.length;

    final bool isValid = (length >= Forms.passwordMinLength &&
        length <= Forms.passwordMaxLength);

    if (isValid && _passwordState == ValidationState.success) return false;

    _setState(
      isValid ? ValidationState.success : ValidationState.error,
      Forms.password,
    );

    _checkIfCanSubmitForm();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _registerFormKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          FormInput(
            controller: _userNameController,
            label: 'Name',
            autoFocus: true,
            onChange: _handleNameFieldChange,
            state: _userNameState,
          ),
          Separator(distanceAsPercent: Numbers.three),
          FormInput(
            controller: _emailAddressController,
            label: 'Email',
            keyBorderType: TextInputType.emailAddress,
            onChange: _handleEmailFieldChange,
            state: _emailState,
            capitalization: TextCapitalization.none,
          ),
          Separator(distanceAsPercent: Numbers.three),
          FormInput(
            controller: _passwordController,
            label: 'Password',
            password: true,
            onChange: _handlePasswordFieldChange,
            state: _passwordState,
          ),
          Separator(),
          CenteredView(
            child: TextRich(
              mainText: 'Have an account',
              richText: 'Sign In',
              onTap: () => pushRoute(
                context: context,
                name: AppRoute.signInView,
              ),
            ),
          ),
          Separator(),
          (!_busy)
              ? ActionButton(
                  buttonType:
                      _canSubmitForm ? ButtonType.primary : ButtonType.disable,
                  text: 'Create',
                  onPressed: () async {
                    setState(() {
                      _busy = true;
                    });
                    print('User Name: ${_userNameController.text}');
                    print('User Email: ${_emailAddressController.text}');
                    print('User Password : ${_passwordController.text}');

                    final User user = User(
                      name: _userNameController.text,
                      email: _emailAddressController.text,
                      password: _passwordController.text,
                    );

                    final res = await context
                        .read<RegisterViewModel>()
                        .register(user: user);

                    print(res);
                    if (res) {
                      pushRoute(
                          context: context, name: AppRoute.shoppingListsView);
                    }
                    setState(() {
                      _busy = false;
                    });
                  },
                  contentPosition: Position.center,
                )
              : Loading(),
          Separator(),
          ContinueWithText(),
          Separator(),
          SocialNetworkIcons()
        ],
      ),
    );
  }
}
