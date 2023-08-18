import 'package:flutter/widgets.dart';
import 'package:liana/src/presentation/base/cubit_helper.dart';
import 'package:liana/src/presentation/common/platform_divider.dart';
import 'package:liana/src/presentation/common/platform_scaffold.dart';
import 'package:liana/src/presentation/common/platform_top_app_bar.dart';
import 'package:liana/src/presentation/screens/settings/cubit/settings_cubit.dart';
import 'package:liana/src/presentation/screens/settings/cubit/settings_state.dart';
import 'package:liana/src/presentation/screens/settings/widgets/switch_settings_iitem.dart';

class SettingsScreenContent extends StatelessWidget
    with CubitHelper<SettingsCubit, SettingsState> {
  const SettingsScreenContent({super.key});

  @override
  Widget build(BuildContext context) {
    return PlatformScaffold(
      topAppBar: platformTopAppBar(
        title: const Text('Настройки'),
      ),
      body: observe(
        builder: (_, state) => Column(
          children: [
            SwitchSettingsItem(
              title: const Text('Использовать системную тему'),
              value: state.settings?.useSystemTheme ?? true,
              onChanged: (value) =>
                  cubit(context)?.setUseSystemTheme(useSystemMode: value),
            ),
            const PlatformDivider(),
            SwitchSettingsItem(
              title: const Text('Темная тема'),
              value: state.settings?.darkMode ?? true,
              onChanged: (value) =>
                  cubit(context)?.setDarkMode(darkMode: value),
            ),
          ],
        ),
      ),
    );
  }
}
