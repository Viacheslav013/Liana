import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:liana/src/presentation/common/platform_widget.dart';
import 'package:liana/src/presentation/themes/cupertino_themes.dart';

class PlatformCircularProgressIndicator extends PlatformWidget {
  const PlatformCircularProgressIndicator({super.key});

  @override
  Widget buildCupertinoWidget(BuildContext context) {
    return const CupertinoActivityIndicator(
      color: progressIndicatorColor,
      radius: 12,
    );
  }

  @override
  Widget buildMaterialWidget(BuildContext context) {
    return const CircularProgressIndicator();
  }
}
