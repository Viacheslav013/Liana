import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Future<T?> showPlatformBottomSheet<T>({
  required BuildContext context,
  required Widget child,
  Color? iosBackgroundColor,
  double? minHeight,
  bool isScrollControlled = false,
}) {
  if (Platform.isIOS) {
    return showCupertinoModalPopup<T>(
      context: context,
      builder: (_) => CupertinoPopupSurface(
        child: Container(
          color: iosBackgroundColor,
          height: minHeight,
          width: double.infinity,
          child: child,
        ),
      ),
    );
  }

  return showModalBottomSheet<T>(
    context: context,
    showDragHandle: true,
    isScrollControlled: isScrollControlled,
    constraints: BoxConstraints(
      minWidth: double.infinity,
      minHeight: minHeight ?? 0,
      maxHeight: minHeight ?? double.infinity,
    ),
    builder: (_) => child,
  );
}
