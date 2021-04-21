import 'package:firebase_core/firebase_core.dart';
import 'package:flash_chat/utils/routes.dart';
import 'package:flutter/material.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(FlashChat());
}

class FlashChat extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: Routes.initial,
      routes: Routes.create(context: context),
    );
  }
}
