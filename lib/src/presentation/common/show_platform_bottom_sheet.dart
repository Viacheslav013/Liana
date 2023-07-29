import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Future<T?> showPlatformBottomSheet<T>({
  required BuildContext context,
  required Widget child,
  Color? iosBackgroundColor,
  double? iosHeight,
}) {
  if (Platform.isIOS) {
    return showCupertinoModalPopup<T>(
      context: context,
      builder: (_) => CupertinoPopupSurface(
        child: Container(
          color: iosBackgroundColor,
          height: iosHeight,
          width: double.infinity,
          child: child,
        ),
      ),
    );
  }

  return showModalBottomSheet<T>(
    context: context,
    showDragHandle: true,
    constraints: const BoxConstraints(minWidth: double.infinity),
    builder: (_) => child,
  );
}
