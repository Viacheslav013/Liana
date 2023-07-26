import 'package:flutter/widgets.dart';
import 'package:liana/src/presentation/common/platform_scaffold.dart';
import 'package:liana/src/presentation/common/platform_top_app_bar.dart';

// TODO: Implement FavoritesScreen
class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return PlatformScaffold(
      topAppBar: platformTopAppBar(
        title: const Text('Избранные'),
      ),
      body: const Center(
        child: Text('Избранные'),
      ),
    );
  }
}
