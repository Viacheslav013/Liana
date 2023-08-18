abstract class SettingsRepository {
  Future<bool> getUseSystemMode();

  Future<void> setUseSystemMode({required bool useSystemMode});

  Future<bool> getDarkMode();

  Future<void> setDarkMode({required bool darkMode});
}
