import 'package:flutter/material.dart';
import 'package:maket/config/routes/router.dart';
import 'package:maket/config/themes/app_theme.dart';
import 'package:maket/utils/locator.dart';

void main() {
  // LicenseRegistry.addLicense(() async* {
  //   const fontDirPath = 'lib/assets/fonts/';
  //   final license = await rootBundle.loadString('${fontDirPath}LICENSE.txt');
  //   yield LicenseEntryWithLineBreaks([fontDirPath], license);
  // });
  setupLocator();
  runApp(Maket());
}

class Maket extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: theme,
      initialRoute: AppRoute.welcomeView,
      onGenerateRoute: AppRoute.generate,
    );
  }
}
