import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:liana/src/presentation/common/platform_widget.dart';

class PlatformDivider extends PlatformWidget {
  const PlatformDivider({super.key});

  @override
  Widget buildCupertinoWidget(BuildContext context) => Container(
        color: CupertinoColors.separator.resolveFrom(context),
        height: 1.0 / MediaQuery.devicePixelRatioOf(context),
      );

  @override
  Widget buildMaterialWidget(BuildContext context) => const Divider(height: 0);
}
