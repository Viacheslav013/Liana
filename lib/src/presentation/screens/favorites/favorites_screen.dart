import 'package:flutter/widgets.dart';
import 'package:liana/src/presentation/base/cubit_host.dart';
import 'package:liana/src/presentation/screens/favorites/cubit/favorites_cubit.dart';
import 'package:liana/src/presentation/screens/favorites/widgets/favorites_screen_content.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const CubitHost<FavoritesCubit>(
      child: FavoritesScreenContent(),
    );
  }
}
