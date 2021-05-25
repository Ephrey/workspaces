import 'package:maket/constants/enums.dart';
import 'package:maket/core/models/user_model.dart';
import 'package:maket/core/services/internal/registration_service.dart';
import 'package:maket/core/viewmodels/base_viewmodel.dart';
import 'package:maket/handlers/exception/api_exception.dart';
import 'package:maket/utils/http/http_headers_keys.dart';
import 'package:maket/utils/http/http_responses.dart';
import 'package:maket/utils/local_storage.dart';
import 'package:maket/utils/locator.dart';

class RegisterViewModel extends BaseViewModel {
  final RegisterService _registerService = locator<RegisterService>();

  Future<HttpResponse> register({User user}) async {
    busy;
    try {
      final token = await _registerService.register(userInfo: user.toJson());

      final bool set = await LocalStorage.set(
        DataType.string,
        HttpHeadersKeys.xToken,
        token,
      );

      idle;

      return (set)
          ? Response.build()
          : Response.build(status: false, message: 'Token not set');
    } on ApiException catch (ex) {
      idle;
      return Response.build(status: false, code: ex.code, message: ex.message);
    } catch (ex) {
      idle;
      return Response.build(status: false, message: 'Failed to Register.');
    }
  }
}
