import 'package:flutter/material.dart';
import 'package:maket/constants/enums.dart';
import 'package:maket/core/viewmodels/user_viewmodel.dart';
import 'package:maket/ui/views/base/base_view.dart';
import 'package:maket/ui/views/base/centered_view.dart';
import 'package:maket/ui/views/base/expanded_view.dart';
import 'package:maket/ui/views/base/padding_view.dart';
import 'package:maket/ui/views/base/scrollable_view.dart';
import 'package:maket/ui/widgets/buttons/action_button.dart';
import 'package:maket/ui/widgets/fields/form_field.dart';
import 'package:maket/ui/widgets/nav_bar.dart';
import 'package:maket/ui/widgets/separator.dart';
import 'package:maket/ui/widgets/snackbar_alert.dart';
import 'package:maket/utils/email.dart';
import 'package:maket/utils/form.dart';
import 'package:maket/utils/http/http_responses.dart';
import 'package:maket/utils/locator.dart';
import 'package:maket/utils/numbers.dart';
import 'package:maket/utils/snackbar/show_snackbar.dart';

class RestorePassword extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BaseView(
      child: PaddingView(
        vertical: 0.0,
        child: Column(
          children: [NavBar(), _RestorePasswordBody()],
        ),
      ),
    );
  }
}

class _RestorePasswordBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ExpandedView(
      flex: Numbers.two,
      child: CenteredView(
        child: ScrollableView(
          child: _RestorePasswordForm(),
        ),
      ),
    );
  }
}

class _RestorePasswordForm extends StatefulWidget {
  @override
  _RestorePasswordFromState createState() => _RestorePasswordFromState();
}

class _RestorePasswordFromState extends State<_RestorePasswordForm> {
  RestorePasswordSteps _currentStep = RestorePasswordSteps.email;

  bool _isLoading = false;
  bool _canSubmit = false;

  bool _invalidOtpErrorShown = false;

  TextEditingController _emailController;
  TextEditingController _otpController;
  TextEditingController _newPasswordController;
  TextEditingController _confirmNewPasswordController;

  Status _emailStatus = Status.normal;
  Status _otpCodeStatus = Status.normal;
  Status _newPasswordStatus = Status.normal;
  Status _confirmNewPasswordStatus = Status.normal;

  // handle input fields

  void _handleEmailField(String email) {
    if (Email.isValid(email: email)) {
      if (_emailStatus == Status.success && _canSubmit) return;

      _activateActionButton();
      _setState(() => _emailStatus = Status.success);
    } else {
      _deactivateActionButton();
      _setState(() => _emailStatus = Status.error);
    }
  }

  void _handleOtpCodeField(String code) {
    if (!Numbers.isIntNumeric(code) && !_invalidOtpErrorShown) {
      _handleOtpCodeError();

      String _message = 'Only Digits are Required';
      _showAlertMessage(status: Status.error, message: _message);
      _invalidOtpErrorShown = !_invalidOtpErrorShown;

      return;
    }

    if (code.length == Numbers.four) {
      _setState(() => _otpCodeStatus = Status.success);
      _activateActionButton();
      if (_invalidOtpErrorShown) _invalidOtpErrorShown = false;
    } else if (code.length > Numbers.four) {
      String _validCode = code.substring(Numbers.zero, Numbers.four);
      _setState(() => _otpController.text = _validCode);
    } else {
      _handleOtpCodeError();
    }
  }

  void _handleNewPasswordField(String password) {
    String _newPwd = _newPasswordController.text;
    String _confirmNewPwd = _confirmNewPasswordController.text;

    if (_areValidPasswords(pwd1: _newPwd, pwd2: _confirmNewPwd)) {
      _setState(() {
        _newPasswordStatus = Status.success;
        _confirmNewPasswordStatus = Status.success;
      });
      _activateActionButton();
    } else {
      if (_newPasswordStatus == Status.normal &&
          _confirmNewPasswordStatus == Status.normal) return;
      _newPasswordStatus = Status.normal;
      _confirmNewPasswordStatus = Status.normal;
      _deactivateActionButton();
    }
  }

  // handle submit forms
  Future<void> _verifyEmail() async {
    _showLoading();
    final _email = _emailController.text;
    final HttpResponse _response =
        await locator<UserViewModel>().verifyEmail(email: _email);

    _hideLoading();

    if (_response.code == 200) {
      _setState(() => _currentStep = RestorePasswordSteps.otpCode);
    } else {
      _showAlertMessage(status: Status.error, message: _response.message);
    }
    _deactivateActionButton();
  }

  Future<void> _verifyOtpCode() async {}

  Future<void> _updatePassword() async {}

  // helper methods
  bool _areValidPasswords({String pwd1, String pwd2}) {
    return pwd1 == pwd2 &&
        pwd1.length >= Forms.passwordMinLength &&
        pwd1.length <= Forms.passwordMaxLength &&
        pwd2.length >= Forms.passwordMinLength &&
        pwd2.length <= Forms.passwordMaxLength;
  }

  void _handleOtpCodeError() {
    _setState(() => _otpCodeStatus = Status.error);
    _deactivateActionButton();
  }

  String _getButtonText() {
    switch (_currentStep) {
      case RestorePasswordSteps.otpCode:
        return 'Submit';
      case RestorePasswordSteps.newPassword:
        return 'Reset';
      case RestorePasswordSteps.email:
      default:
        return 'Next';
    }
  }

  void _showAlertMessage({Status status, String message}) {
    showSnackBar(
      context: context,
      flavor: status,
      content: SnackBarAlert(message: message),
    );
  }

  void _onActionButtonTap() {
    switch (_currentStep) {
      case RestorePasswordSteps.email:
        _verifyEmail();
        break;
      case RestorePasswordSteps.otpCode:
        _verifyOtpCode();
        break;
      case RestorePasswordSteps.newPassword:
        _updatePassword();
        break;
    }
  }

  void _updateCurrentStep({RestorePasswordSteps step}) {
    _setState(() => _currentStep = step);
  }

  void _activateActionButton() => _setState(() => _canSubmit = true);
  void _deactivateActionButton() => _setState(() => _canSubmit = false);

  void _showLoading() => _setState(() => _isLoading = true);
  void _hideLoading() => _setState(() => _isLoading = false);

  _setState(Function fn) => super.setState(fn);

  @override
  void initState() {
    _emailController = TextEditingController();
    _otpController = TextEditingController();
    _newPasswordController = TextEditingController();
    _confirmNewPasswordController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _otpController.dispose();
    _newPasswordController.dispose();
    _confirmNewPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (_currentStep == RestorePasswordSteps.email)
          FormInput(
            controller: _emailController,
            label: 'Email',
            keyBorderType: TextInputType.emailAddress,
            capitalization: TextCapitalization.none,
            textAlign: TextAlign.center,
            autoFocus: true,
            state: _emailStatus,
            onChange: _handleEmailField,
          ),
        if (_currentStep == RestorePasswordSteps.otpCode)
          FormInput(
            controller: _otpController,
            hintText: 'Enter Confirmation Code',
            keyBorderType: TextInputType.number,
            autoFocus: true,
            textAlign: TextAlign.center,
            state: _otpCodeStatus,
            onChange: _handleOtpCodeField,
          ),
        if (_currentStep == RestorePasswordSteps.newPassword)
          FormInput(
            controller: _newPasswordController,
            hintText: 'Enter New Password',
            autoFocus: true,
            password: true,
            textAlign: TextAlign.center,
            state: _newPasswordStatus,
            onChange: _handleNewPasswordField,
          ),
        if (_currentStep == RestorePasswordSteps.newPassword)
          Separator(distanceAsPercent: Numbers.three),
        if (_currentStep == RestorePasswordSteps.newPassword)
          FormInput(
            controller: _confirmNewPasswordController,
            hintText: 'Confirm New Password',
            password: true,
            textAlign: TextAlign.center,
            state: _confirmNewPasswordStatus,
            onChange: _handleNewPasswordField,
          ),
        Separator(distanceAsPercent: Numbers.three),
        ActionButton(
          buttonType: (_canSubmit && !_isLoading)
              ? ButtonType.primary
              : ButtonType.disable,
          text: _getButtonText(),
          onPressed: _onActionButtonTap,
          iconPosition: Position.right,
          contentPosition: Position.center,
          loading: _isLoading,
        )
      ],
    );
  }
}
