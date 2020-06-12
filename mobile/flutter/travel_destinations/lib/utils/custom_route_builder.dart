import 'package:flutter/material.dart';

Route buildCustomRoute(routePrimaryContent) {
  return PageRouteBuilder(
    pageBuilder: (context, _, __) => routePrimaryContent,
    transitionsBuilder: (context, animation, ___, child) {
      final curve = Curves.bounceInOut;
      final tween = Tween(begin: .0, end: 1.0);
      final curvedAnimation = CurvedAnimation(curve: curve, parent: animation);

      return FadeTransition(
        opacity: tween.animate(curvedAnimation),
        child: child,
      );
    },
  );
}
