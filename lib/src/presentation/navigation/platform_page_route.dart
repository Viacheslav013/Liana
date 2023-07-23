import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

PageRoute<T> platformPageRoute<T>({
  required RouteSettings? settings,
  required Widget Function(BuildContext) builder,
}) {
  if (Platform.isIOS) {
    return CupertinoPageRoute<T>(
      settings: settings,
      builder: builder,
    );
  }

  return MaterialPageRoute<T>(
    settings: settings,
    builder: builder,
  );
}
