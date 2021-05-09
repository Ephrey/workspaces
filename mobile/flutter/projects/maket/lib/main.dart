import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:maket/config/themes/app_theme.dart';
import 'package:maket/ui/views/base/shopping_list_view.dart';

void main() {
  LicenseRegistry.addLicense(() async* {
    const fontDirPath = 'lib/assets/fonts/';
    final license = await rootBundle.loadString('${fontDirPath}LICENSE.txt');
    yield LicenseEntryWithLineBreaks([fontDirPath], license);
  });
  runApp(Maket());
}

class Maket extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: theme,
      home: ShoppingListView(),
    );
  }
}
