import 'package:flutter/foundation.dart';
import 'package:maket/core/models/user_model.dart';
import 'package:maket/core/services/apis/internal/registration_service.dart';
import 'package:maket/handlers/exception/api_exception.dart';
import 'package:maket/utils/locator.dart';

class RegisterViewModel extends ChangeNotifier {
  final RegisterService _registerService = locator<RegisterService>();

  Future<dynamic> register({User user}) async {
    final userToJson = user.toJson();
    print(userToJson);
    try {
      final token = await _registerService.register(userToJson);
      if (token != null) {
        // store the toke in local storage
        print(token);
      }
      return token != null;
    } on ApiException catch (exception) {
      return exception.message;
    }
  }
}
