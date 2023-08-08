import 'dart:io';

import 'package:flutter/cupertino.dart';

PageRoute<T> platformPageRoute<T>({
  required Widget Function(BuildContext) builder,
  RouteSettings? settings,
}) {
  if (Platform.isIOS) {
    return CupertinoPageRoute<T>(
      settings: settings,
      builder: builder,
    );
  }

  return PageRouteBuilder<T>(
    settings: settings,
    pageBuilder: (context, __, ___) => builder(context),
    transitionDuration: const Duration(milliseconds: 200),
    reverseTransitionDuration: const Duration(milliseconds: 200),
    transitionsBuilder: (
      _,
      animation,
      secondAnimation,
      child,
    ) =>
        FadeTransition(
      opacity: animation,
      child: SlideTransition(
        position: Tween(
          begin: const Offset(1, 0),
          end: Offset.zero,
        ).animate(animation),
        child: SlideTransition(
          position: Tween(
            begin: Offset.zero,
            end: const Offset(1, 0),
          ).animate(secondAnimation),
          child: child,
        ),
      ),
    ),
  );
}
