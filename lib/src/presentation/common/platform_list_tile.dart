import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:liana/src/presentation/common/platform_widget.dart';

class PlatformListTile extends PlatformWidget {
  const PlatformListTile({
    required this.title,
    this.leading,
    this.trailing,
    this.subtitle,
    super.key,
  });

  final Widget? leading;
  final Widget? trailing;
  final Widget title;
  final Widget? subtitle;

  @override
  Widget buildCupertinoWidget(BuildContext context) {
    return CupertinoListTile(
      leading: leading,
      trailing: trailing,
      title: title,
      subtitle: subtitle,
    );
  }

  @override
  Widget buildMaterialWidget(BuildContext context) {
    return ListTile(
      leading: leading,
      trailing: trailing,
      title: title,
      subtitle: subtitle,
    );
  }
}
