import 'package:flutter/cupertino.dart';

void pushRoute({BuildContext context, String name, Object arguments}) {
  Navigator.of(context).pushNamed(name, arguments: arguments);
}
