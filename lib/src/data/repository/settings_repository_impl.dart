import 'package:injectable/injectable.dart';
import 'package:liana/src/domain/repository/settings_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

const _useSystemModeKey = 'useSystemMode';
const _darkModeKey = 'darkMode';

@Singleton(as: SettingsRepository)
class SettingsRepositoryImpl implements SettingsRepository {
  const SettingsRepositoryImpl(this._sharedPreferences);

  final SharedPreferences _sharedPreferences;

  @override
  Future<bool> getUseSystemMode() async =>
      _sharedPreferences.getBool(_useSystemModeKey) ?? true;

  @override
  Future<void> setUseSystemMode({required bool useSystemMode}) async =>
      _sharedPreferences.setBool(_useSystemModeKey, useSystemMode);

  @override
  Future<bool> getDarkMode() async =>
      _sharedPreferences.getBool(_darkModeKey) ?? false;

  @override
  Future<void> setDarkMode({required bool darkMode}) async =>
      _sharedPreferences.setBool(_darkModeKey, darkMode);
}
