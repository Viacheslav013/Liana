import 'package:flutter/widgets.dart';
import 'package:liana/src/presentation/common/platform_scaffold.dart';
import 'package:liana/src/presentation/common/platform_top_app_bar.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return PlatformScaffold(
      topAppBar: platformTopAppBar(
        title: const Text('Настройки'),
      ),
      body: const Center(
        child: Text('Настройки'),
      ),
    );
  }
}
