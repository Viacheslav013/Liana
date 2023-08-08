import 'package:flutter/cupertino.dart';
import 'package:liana/src/presentation/common/platform_widget.dart';

class PlatformIcon extends PlatformWidget {
  const PlatformIcon({
    required this.iosIcon,
    required this.materialIcon,
    this.color,
    super.key,
  });

  final IconData iosIcon;
  final IconData materialIcon;
  final Color? color;

  @override
  Widget buildCupertinoWidget(BuildContext context) {
    return Icon(iosIcon, color: color);
  }

  @override
  Widget buildMaterialWidget(BuildContext context) {
    return Icon(materialIcon, color: color);
  }
}
