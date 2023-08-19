import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:liana/src/presentation/base/cubit_helper.dart';
import 'package:liana/src/presentation/common/platform_divider.dart';
import 'package:liana/src/presentation/common/platform_scaffold.dart';
import 'package:liana/src/presentation/common/platform_top_app_bar.dart';
import 'package:liana/src/presentation/localization/supported_locales.dart';
import 'package:liana/src/presentation/screens/settings/cubit/settings_cubit.dart';
import 'package:liana/src/presentation/screens/settings/cubit/settings_state.dart';
import 'package:liana/src/presentation/screens/settings/widgets/picker_settings_item.dart';
import 'package:liana/src/presentation/screens/settings/widgets/switch_settings_iitem.dart';

class SettingsScreenContent extends StatelessWidget
    with CubitHelper<SettingsCubit, SettingsState> {
  const SettingsScreenContent({super.key});

  TextStyle? _getValueTextStyle(BuildContext context) {
    return Platform.isIOS
        ? CupertinoTheme.of(context).textTheme.textStyle
        : Theme.of(context).textTheme.bodyLarge;
  }

  TextStyle? _getPickerTitleStyle(BuildContext context) {
    return Platform.isIOS
        ? CupertinoTheme.of(context).textTheme.navTitleTextStyle
        : Theme.of(context).textTheme.titleLarge;
  }

  @override
  Widget build(BuildContext context) {
    return PlatformScaffold(
      topAppBar: platformTopAppBar(
        title: Text('settings_screen_title'.tr()),
      ),
      body: observe(
        builder: (_, state) => Column(
          children: [
            SwitchSettingsItem(
              title: Text('settings_screen_use_system_theme'.tr()),
              value: state.settings?.useSystemTheme ?? true,
              onChanged: (value) =>
                  cubit(context)?.setUseSystemTheme(useSystemMode: value),
            ),
            const PlatformDivider(),
            SwitchSettingsItem(
              title: Text('settings_screen_dark_mode'.tr()),
              value: state.settings?.darkMode ?? true,
              onChanged: (value) =>
                  cubit(context)?.setDarkMode(darkMode: value),
            ),
            const PlatformDivider(),
            PickerSettingsItem(
              title: Text('settings_screen_language'.tr()),
              value: Text(
                supportedLocales[context.locale] ??
                    supportedLocales.values.first,
                style: _getValueTextStyle(context),
              ),
              pickerTitle: Text(
                'settings_screen_choose_language'.tr(),
                style: _getPickerTitleStyle(context),
              ),
              pickerItems: [
                for (final supportedLocale in supportedLocales.entries)
                  PickerItem<String>(
                    title: Text(supportedLocale.value),
                    value: supportedLocale.key.languageCode,
                    selected: context.locale == supportedLocale.key,
                    onTap: () => cubit(context)?.setLocale(
                      supportedLocale.key.languageCode,
                    ),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
