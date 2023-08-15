import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Future<T?> showPlatformDialog<T>({
  required BuildContext context,
  bool barrierDismissible = true,
  Widget? title,
  Widget? content,
  List<PlatformDialogAction>? actions,
}) async {
  if (Platform.isIOS) {
    return showCupertinoModalPopup<T>(
      context: context,
      barrierDismissible: barrierDismissible,
      builder: (_) => CupertinoAlertDialog(
        title: title,
        content: content,
        actions: actions?.map((action) => action._toCupertino()).toList() ?? [],
      ),
    );
  }

  return showDialog<T>(
    context: context,
    barrierDismissible: barrierDismissible,
    builder: (_) => AlertDialog(
      title: title,
      content: content,
      actions: actions?.map((action) => action._toMaterial()).toList(),
    ),
  );
}

class PlatformDialogAction {
  const PlatformDialogAction({
    required this.text,
    required this.onPressed,
    required this.isDefaultAction,
  });

  final String text;
  final VoidCallback onPressed;
  final bool isDefaultAction;

  CupertinoDialogAction _toCupertino() {
    return CupertinoDialogAction(
      isDefaultAction: isDefaultAction,
      onPressed: onPressed,
      child: Text(text),
    );
  }

  Widget _toMaterial() {
    return TextButton(
      onPressed: onPressed,
      child: Text(text),
    );
  }
}
