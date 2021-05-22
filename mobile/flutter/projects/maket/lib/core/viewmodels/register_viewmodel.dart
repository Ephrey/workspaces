import 'package:flutter/foundation.dart';
import 'package:maket/constants/enums.dart';
import 'package:maket/core/models/user_model.dart';
import 'package:maket/core/services/apis/internal/registration_service.dart';
import 'package:maket/handlers/exception/api_exception.dart';
import 'package:maket/utils/http/http_headers_keys.dart';
import 'package:maket/utils/http/http_responses.dart';
import 'package:maket/utils/local_storage.dart';
import 'package:maket/utils/locator.dart';

class RegisterViewModel extends ChangeNotifier {
  final RegisterService _registerService = locator<RegisterService>();

  Future<HttpResponse> register({User user}) async {
    try {
      final token = await _registerService.register(userInfo: user.toJson());
      final set = await LocalStorage.set(
        DataType.string,
        HttpHeadersKeys.xToken,
        token,
      );
      return (set)
          ? Response.build()
          : Response.build(status: false, message: 'token to set');
    } on ApiException catch (ex) {
      return Response.build(status: false, code: ex.code, message: ex.message);
    } catch (ex) {
      return Response.build(status: false, message: 'Failed to Register.');
    }
  }
}
