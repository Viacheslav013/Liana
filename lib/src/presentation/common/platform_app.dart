import 'package:easy_localization/easy_localization.dart';
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

  void _stateListener(BuildContext context, SettingsState state) {
    final locale = state.settings?.locale;
    if (locale != null) {
      context.setLocale(Locale(locale));
      rebuildAllWidgets(context);
    }
  }

  void rebuildAllWidgets(BuildContext context) {
    void rebuild(Element el) {
      el
        ..markNeedsBuild()
        ..visitChildren(rebuild);
    }

    (context as Element).visitChildren(rebuild);
  }

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
      child: consume(
        listener: (_, state) => _stateListener(context, state),
        builder: (_, state) => CupertinoApp(
          title: _title,
          home: home,
          localizationsDelegates: context.localizationDelegates,
          supportedLocales: context.supportedLocales,
          locale: context.locale,
          theme: cupertinoTheme.copyWith(
            brightness: _getCupertinoBrightness(
              useSystemTheme: state.settings?.useSystemTheme ?? true,
              darkMode: state.settings?.darkMode ?? false,
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget buildMaterialWidget(BuildContext context) {
    return CubitHost<SettingsCubit>(
      child: consume(
        listener: (_, state) => _stateListener(context, state),
        builder: (_, state) => MaterialApp(
          title: _title,
          home: home,
          localizationsDelegates: context.localizationDelegates,
          supportedLocales: context.supportedLocales,
          locale: context.locale,
          theme: lightMaterialTheme,
          darkTheme: darkMaterialTheme,
          themeMode: _getMaterialThemeMode(
            useSystemTheme: state.settings?.useSystemTheme ?? true,
            darkMode: state.settings?.darkMode ?? false,
          ),
        ),
      ),
    );
  }
}
