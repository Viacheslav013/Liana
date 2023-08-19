abstract class SettingsRepository {
  Future<bool> getUseSystemMode();

  Future<void> setUseSystemMode({required bool useSystemMode});

  Future<bool> getDarkMode();

  Future<void> setDarkMode({required bool darkMode});

  Future<String?> getLocale();

  Future<void> setLocale(String locale);
}
