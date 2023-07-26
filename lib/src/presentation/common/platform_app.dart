import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:liana/src/presentation/common/platform_widget.dart';
import 'package:liana/src/presentation/themes/cupertino_themes.dart';
import 'package:liana/src/presentation/themes/material_themes.dart';

const _title = 'Liana';

class PlatformApp extends PlatformWidget {
  const PlatformApp({
    required this.home,
    super.key,
  });

  final Widget home;

  @override
  Widget buildCupertinoWidget(BuildContext context) {
    return CupertinoApp(
      title: _title,
      home: home,
      theme: cupertinoTheme,
    );
  }

  @override
  Widget buildMaterialWidget(BuildContext context) {
    return MaterialApp(
      title: _title,
      home: home,
      theme: lightMaterialTheme,
      darkTheme: darkMaterialTheme,
    );
  }
}
