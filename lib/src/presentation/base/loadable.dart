import 'package:flutter/widgets.dart';
import 'package:liana/src/presentation/common/platform_circular_progress_indicator.dart';

class Loadable extends StatelessWidget {
  const Loadable({
    required this.isLoading,
    required this.child,
    super.key,
  });

  final bool isLoading;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: AlignmentDirectional.center,
      children: [
        child,
        if (isLoading) const PlatformCircularProgressIndicator(),
      ],
    );
  }
}
