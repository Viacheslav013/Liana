import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:liana/src/presentation/themes/cupertino_themes.dart';

PreferredSizeWidget platformTopAppBar({
  Widget? leading,
  Widget? title,
  Widget? trailing,
  List<Widget>? actions,
  String? previousPageTitle,
}) {
  if (Platform.isIOS) {
    return CupertinoNavigationBar(
      leading: leading,
      middle: title,
      trailing: trailing,
      previousPageTitle: previousPageTitle,
      border: Border(
        bottom: BorderSide(
          color: navigationBarBordersColor,
          width: 0,
        ),
      ),
    );
  }

  return AppBar(
    leading: leading,
    title: title,
    actions: actions,
  );
}
