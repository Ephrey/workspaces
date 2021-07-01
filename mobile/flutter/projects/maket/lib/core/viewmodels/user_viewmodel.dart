import 'package:maket/constants/enums.dart';
import 'package:maket/core/models/user_model.dart' show UserLogin;
import 'package:maket/core/services/internal/user_service.dart';
import 'package:maket/core/viewmodels/base_viewmodel.dart';
import 'package:maket/handlers/exception/api_exception.dart';
import 'package:maket/utils/http/http_headers_keys.dart';
import 'package:maket/utils/http/http_responses.dart';
import 'package:maket/utils/local_storage.dart';
import 'package:maket/utils/locator.dart';

class UserViewModel extends BaseViewModel {
  final UserService _userService = locator<UserService>();

  Future<HttpResponse> login({UserLogin user}) async {
    busy;
    try {
      final String _token = await _userService.login(userInfo: user.toJson());

      final bool _set = await LocalStorage.set(
        dataType: DataType.string,
        key: HttpHeadersKeys.xToken,
        value: _token,
      );

      idle;

      return (_set)
          ? Response.build()
          : Response.build(status: false, message: 'Token not set');
    } on ApiException catch (ex) {
      idle;
      return Response.build(status: false, code: ex.code, message: ex.message);
    } catch (ex) {
      idle;
      return Response.build(status: false, message: 'Failed to Login');
    }
  }

  Future<HttpResponse> verifyEmail({String email}) async {
    try {
      HttpResponse _response = await _userService.verifyEmail(email: email);
      return Response.build(code: _response.code, message: _response.message);
    } on ApiException catch (ex) {
      print("Verify Email Api. Ex. : ${ex.message}");
      return Response.build(status: false, code: ex.code, message: ex.message);
    } catch (ex) {
      print("Verify Email Ex. : $ex");
      return Response.build(
        code: Response.internalServerError,
        status: false,
        message: 'Could not verify your email',
      );
    }
  }

  Future<HttpResponse> verifyOtpCode({String otpCode, String email}) async {
    try {
      HttpResponse _response =
          await _userService.verifyOtpCode(otpCode: otpCode, email: email);

      return Response.build(
        status: _response.status,
        code: _response.code,
        message: _response.message,
      );
    } on ApiException catch (ex) {
      print(ex.message);
      print(ex.code);
      return Response.build(status: false, code: ex.code, message: ex.message);
    } catch (ex) {
      print(ex);
      final _message = 'Unable to verify your code';
      return Response.build(status: false, message: _message);
    }
  }

  Future<HttpResponse> updatePassword({
    String newPassword,
    String email,
  }) async {
    try {
      HttpResponse _response = await _userService.updatePassword(
        newPassword: newPassword,
        email: email,
      );

      if (_response.data.isNotEmpty) {
        await LocalStorage.set(
          dataType: DataType.string,
          key: HttpHeadersKeys.xToken,
          value: _response.data,
        );
      }

      return Response.build(
        status: _response.status,
        code: _response.code,
        message: _response.message,
      );
    } on ApiException catch (ex) {
      print(ex.message);
      print(ex.code);
      return Response.build(status: false, code: ex.code, message: ex.message);
    } catch (ex) {
      print(ex);
      final _message = 'Unable to Update your password';
      return Response.build(status: false, message: _message);
    }
  }
}
