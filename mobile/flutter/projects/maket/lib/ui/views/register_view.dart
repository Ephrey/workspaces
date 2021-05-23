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
import 'package:maket/ui/widgets/snackbar_alert.dart';
import 'package:maket/ui/widgets/social_network_icons.dart';
import 'package:maket/ui/widgets/texts/rich_text.dart';
import 'package:maket/utils/email.dart';
import 'package:maket/utils/form.dart';
import 'package:maket/utils/http/http_responses.dart';
import 'package:maket/utils/locator.dart';
import 'package:maket/utils/navigation/push.dart';
import 'package:maket/utils/numbers.dart';
import 'package:maket/utils/show_snackbar.dart';
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

  Status _userNameState;
  Status _emailState;
  Status _passwordState;

  bool _canSubmitForm = false;
  ViewState _registerViewState = ViewState.idle;

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

  void _setState(callback) {
    setState(callback);
  }

  _checkIfCanSubmitForm() {
    _setState(
      () => _canSubmitForm = (_userNameState == Status.success &&
          _emailState == Status.success &&
          _passwordState == Status.success),
    );
  }

  _handleNameFieldChange(String userName) {
    final int nameLength = userName.length;
    final bool _isNameValid = (nameLength > Forms.usernameMinLength &&
        nameLength <= Forms.usernameMaxLength);

    if (_isNameValid && (_userNameState == Status.success)) return false;

    _setState(() => _userNameState = _getFieldState(_isNameValid));
    _checkIfCanSubmitForm();
  }

  _handleEmailFieldChange(String email) {
    final bool _isEmailValid = Email.isValid(email);

    if (_isEmailValid && (_emailState == Status.success)) return false;

    _setState(() => _emailState = _getFieldState(_isEmailValid));
    _checkIfCanSubmitForm();
  }

  _handlePasswordFieldChange(dynamic password) {
    final int passwordLength = password.length;

    final bool _isPasswordValid = (passwordLength >= Forms.passwordMinLength &&
        passwordLength <= Forms.passwordMaxLength);

    if (_isPasswordValid && _passwordState == Status.success) return false;

    _setState(() => _passwordState = _getFieldState(_isPasswordValid));
    _checkIfCanSubmitForm();
  }

  Future<void> _handleFormSubmit({BuildContext context}) async {
    _setState(() => _registerViewState = ViewState.busy);

    final User user = User(
      name: _userNameController.text,
      email: _emailAddressController.text,
      password: _passwordController.text,
    );

    final HttpResponse response =
        await context.read<RegisterViewModel>().register(user: user);

    if (response.status == true) {
      pushRoute(context: context, name: AppRoute.shoppingListsView);
    } else {
      showSnackBar(
        context: context,
        content: SnackBarAlert(message: response.message),
        flavor: Status.error,
      );
      _setState(() => _registerViewState = ViewState.idle);
    }
  }

  Status _getFieldState(bool state) => (state) ? Status.success : Status.error;

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
          (_registerViewState == ViewState.busy)
              ? Loading()
              : ActionButton(
                  buttonType:
                      _canSubmitForm ? ButtonType.primary : ButtonType.disable,
                  text: 'Create',
                  onPressed: () => _handleFormSubmit(context: context),
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
