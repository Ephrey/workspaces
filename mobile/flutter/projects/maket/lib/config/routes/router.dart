import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:maket/ui/views/base/base_view.dart';
import 'package:maket/ui/views/base/centered_view.dart';
import 'package:maket/ui/views/create_shopping_list_view.dart';
import 'package:maket/ui/views/register_view.dart';
import 'package:maket/ui/views/shopping_lists_view.dart';
import 'package:maket/ui/views/sign_in_view.dart';
import 'package:maket/ui/views/welcome_view.dart';

class AppRoute {
  static const String welcomeView = 'welcome';
  static const String signInView = 'signIn';
  static const String registerView = 'register';
  static const String shoppingListsView = 'shopping_list_view';
  static const String createShoppingList = 'create_shopping_list';

  static Route<dynamic> generate(RouteSettings settings) {
    switch (settings.name) {
      case welcomeView:
        return MaterialPageRoute(builder: (_) => WelcomeView());
      case signInView:
        return MaterialPageRoute(builder: (_) => SignInView());
      case registerView:
        return MaterialPageRoute(builder: (_) => RegisterView());
      case shoppingListsView:
        return MaterialPageRoute(builder: (_) => ShoppingListsView());
      case createShoppingList:
        return MaterialPageRoute(builder: (_) => CreateShoppingListView());
      default:
        return MaterialPageRoute(
          builder: (_) => BaseView(
            child: CenteredView(
              child: Text('No such route for ${settings.name}'),
            ),
          ),
        );
    }
  }
}