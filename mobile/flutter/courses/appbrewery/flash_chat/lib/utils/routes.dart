import 'package:flash_chat/screens/chat_screen.dart';
import 'package:flash_chat/screens/login_screen.dart';
import 'package:flash_chat/screens/registration_screen.dart';
import 'package:flash_chat/screens/welcome_screen.dart';
import 'package:flutter/material.dart';

class Routes {
  Routes._();

  static const String welcome = 'welcome';
  static const String login = 'login';
  static const String register = 'register';
  static const String chat = 'chat';

  static const String initial = welcome;

  static Map<String, WidgetBuilder> create({@required BuildContext context}) {
    return {
      welcome: (BuildContext buildContext) => WelcomeScreen(),
      login: (BuildContext buildContext) => LoginScreen(),
      register: (BuildContext buildContext) => RegistrationScreen(),
      chat: (BuildContext buildContext) => ChatScreen(),
    };
  }
}
