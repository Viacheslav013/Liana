import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:liana/src/presentation/common/platform_widget.dart';

class PlatformButton extends PlatformWidget {
  const PlatformButton({
    required this.onPressed,
    required this.child,
    this.padding,
    super.key,
  });

  final VoidCallback onPressed;
  final Widget child;
  final EdgeInsets? padding;

  @override
  Widget buildCupertinoWidget(BuildContext context) {
    return CupertinoButton(
      onPressed: onPressed,
      padding: padding,
      child: child,
    );
  }

  @override
  Widget buildMaterialWidget(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      child: child,
    );
  }
}
