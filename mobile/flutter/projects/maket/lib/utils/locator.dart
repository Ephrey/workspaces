import 'package:get_it/get_it.dart';
import 'package:maket/core/services/internal/item_service.dart';
import 'package:maket/core/services/internal/login_service.dart';
import 'package:maket/core/services/internal/registration_service.dart';
import 'package:maket/core/viewmodels/item_viewmodel.dart';
import 'package:maket/core/viewmodels/register_viewmodel.dart';
import 'package:maket/core/viewmodels/sign_in_viewmodel.dart';

final GetIt locator = GetIt.instance;

void setupLocator() {
  locator.registerFactory<RegisterViewModel>(() => RegisterViewModel());
  locator.registerFactory<SignInViewModel>(() => SignInViewModel());
  locator.registerFactory<ItemViewModel>(() => ItemViewModel());

  locator.registerLazySingleton<RegisterService>(() => RegisterService());
  locator.registerLazySingleton<LoginService>(() => LoginService());
  locator.registerLazySingleton<ItemService>(() => ItemService());
}
