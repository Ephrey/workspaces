import 'package:get_it/get_it.dart';
import 'package:maket/core/services/internal/item_service.dart';
import 'package:maket/core/services/internal/login_service.dart';
import 'package:maket/core/services/internal/registration_service.dart';
import 'package:maket/core/services/internal/shopping_list_service.dart';
import 'package:maket/core/viewmodels/item_viewmodel.dart';
import 'package:maket/core/viewmodels/register_viewmodel.dart';
import 'package:maket/core/viewmodels/shopping_list_viewmodel.dart';
import 'package:maket/core/viewmodels/sign_in_viewmodel.dart';
import 'package:maket/utils/date.dart';

final GetIt locator = GetIt.instance;

void setupLocator() {
  locator.registerFactory<RegisterViewModel>(() => RegisterViewModel());
  locator.registerFactory<SignInViewModel>(() => SignInViewModel());
  locator.registerLazySingleton<ItemViewModel>(() => ItemViewModel());
  locator.registerLazySingleton<ShoppingListViewModel>(
      () => ShoppingListViewModel());

  locator.registerLazySingleton<RegisterService>(() => RegisterService());
  locator.registerLazySingleton<LoginService>(() => LoginService());
  locator.registerLazySingleton<ItemService>(() => ItemService());
  locator
      .registerLazySingleton<ShoppingListService>(() => ShoppingListService());
  locator.registerLazySingleton<Date>(() => Date());
}
