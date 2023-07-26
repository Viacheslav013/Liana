import 'package:flutter/widgets.dart';
import 'package:liana/src/presentation/common/platform_app.dart';
import 'package:liana/src/presentation/screens/root/root_screen.dart';

class LianaApp extends StatelessWidget {
  const LianaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const PlatformApp(home: RootScreen());
  }
}
