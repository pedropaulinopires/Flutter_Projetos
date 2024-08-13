import 'package:flutter/material.dart';

class AppCreateRoute {
  static Route createRoute(Widget widget, {bool animatedExecut = true}) {
    return PageRouteBuilder(
      opaque: true,
      pageBuilder: (context, animation, secondaryAnimation) => widget,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        var begin = animatedExecut ? const Offset(1, 0) : const Offset(0, 0);
        var end = Offset.zero;
        var curve = Curves.fastOutSlowIn;

        var tween =
            Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

        return SlideTransition(
          position: animation.drive(tween),
          child: child,
        );
      },
    );
  }
}
