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
  final UserService _loginService = locator<UserService>();

  Future<HttpResponse> login({UserLogin user}) async {
    busy;
    try {
      final String _token = await _loginService.login(userInfo: user.toJson());

      final bool _set = await LocalStorage.set(
        DataType.string,
        HttpHeadersKeys.xToken,
        _token,
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
      HttpResponse _response = await _loginService.verifyEmail(email: email);
      return Response.build(code: _response.code, message: _response.message);
    } on ApiException catch (ex) {
      print(ex.message);
      return Response.build(status: false, code: ex.code, message: ex.message);
    } catch (ex) {
      print(ex);
      final _message = 'Could not verify your email';
      return Response.build(status: false, message: _message);
    }
  }
}
