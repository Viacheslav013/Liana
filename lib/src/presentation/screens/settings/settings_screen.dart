import 'package:flutter/widgets.dart';
import 'package:liana/src/presentation/base/cubit_host.dart';
import 'package:liana/src/presentation/screens/settings/cubit/settings_cubit.dart';
import 'package:liana/src/presentation/screens/settings/widgets/settings_screen_content.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const CubitHost<SettingsCubit>(
      child: SettingsScreenContent(),
    );
  }
}
