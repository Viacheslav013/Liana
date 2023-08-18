import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:liana/src/presentation/base/cubit_helper.dart';
import 'package:liana/src/presentation/base/cubit_host.dart';
import 'package:liana/src/presentation/common/platform_widget.dart';
import 'package:liana/src/presentation/screens/settings/cubit/settings_cubit.dart';
import 'package:liana/src/presentation/screens/settings/cubit/settings_state.dart';
import 'package:liana/src/presentation/themes/cupertino_themes.dart';
import 'package:liana/src/presentation/themes/material_themes.dart';

const _title = 'Liana';

class PlatformApp extends PlatformWidget
    with CubitHelper<SettingsCubit, SettingsState> {
  const PlatformApp({
    required this.home,
    super.key,
  });

  final Widget home;

  Brightness? _getCupertinoBrightness({
    required bool useSystemTheme,
    required darkMode,
  }) {
    if (useSystemTheme) {
      return null;
    }

    return darkMode ? Brightness.dark : Brightness.light;
  }

  ThemeMode? _getMaterialThemeMode({
    required bool useSystemTheme,
    required darkMode,
  }) {
    if (useSystemTheme) {
      return null;
    }

    return darkMode ? ThemeMode.dark : ThemeMode.light;
  }

  @override
  Widget buildCupertinoWidget(BuildContext context) {
    return CubitHost<SettingsCubit>(
      child: observe(
        builder: (_, state) => state.settings != null
            ? CupertinoApp(
                title: _title,
                home: home,
                theme: cupertinoTheme.copyWith(
                  brightness: _getCupertinoBrightness(
                    useSystemTheme: state.settings?.useSystemTheme ?? true,
                    darkMode: state.settings?.darkMode ?? false,
                  ),
                ),
              )
            : Container(),
      ),
    );
  }

  @override
  Widget buildMaterialWidget(BuildContext context) {
    return CubitHost<SettingsCubit>(
      child: observe(
        builder: (_, state) => state.settings != null
            ? MaterialApp(
                title: _title,
                home: home,
                theme: lightMaterialTheme,
                darkTheme: darkMaterialTheme,
                themeMode: _getMaterialThemeMode(
                  useSystemTheme: state.settings?.useSystemTheme ?? true,
                  darkMode: state.settings?.darkMode ?? false,
                ),
              )
            : Container(),
      ),
    );
  }
}
