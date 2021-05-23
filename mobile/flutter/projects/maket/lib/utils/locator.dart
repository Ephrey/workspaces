import 'package:get_it/get_it.dart';
import 'package:maket/core/services/internal/login_service.dart';
import 'package:maket/core/services/internal/registration_service.dart';
import 'package:maket/core/viewmodels/login_viewmodel.dart';
import 'package:maket/core/viewmodels/register_viewmodel.dart';

final GetIt locator = GetIt.instance;

void setupLocator() {
  locator.registerLazySingleton<RegisterViewModel>(() => RegisterViewModel());
  locator.registerLazySingleton<LoginViewModel>(() => LoginViewModel());

  locator.registerLazySingleton<RegisterService>(() => RegisterService());
  locator.registerLazySingleton<LoginService>(() => LoginService());
}
