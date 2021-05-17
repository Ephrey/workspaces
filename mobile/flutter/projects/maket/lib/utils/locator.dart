import 'package:get_it/get_it.dart';
import 'package:maket/core/viewmodels/login_view_model.dart';

final GetIt locator = GetIt.instance;

void setupLocator() {
  locator.registerLazySingleton<LoginViewModel>(() => LoginViewModel());
}
