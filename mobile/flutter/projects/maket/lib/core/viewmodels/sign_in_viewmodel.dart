import 'package:maket/constants/enums.dart';
import 'package:maket/core/models/user_model.dart' show UserLogin;
import 'package:maket/core/services/internal/login_service.dart';
import 'package:maket/core/viewmodels/base_viewmodel.dart';
import 'package:maket/handlers/exception/api_exception.dart';
import 'package:maket/utils/http/http_headers_keys.dart';
import 'package:maket/utils/http/http_responses.dart';
import 'package:maket/utils/local_storage.dart';
import 'package:maket/utils/locator.dart';

class SignInViewModel extends BaseViewModel {
  final LoginService _loginService = locator<LoginService>();

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
}