import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:liana/src/domain/entity/settings.dart';
import 'package:liana/src/domain/repository/settings_repository.dart';
import 'package:liana/src/presentation/screens/settings/cubit/settings_state.dart';

@singleton
class SettingsCubit extends Cubit<SettingsState> {
  SettingsCubit(
    this._settingsRepository,
  ) : super(const SettingsState()) {
    _loadSettings();
  }

  final SettingsRepository _settingsRepository;

  Future<void> _loadSettings() async {
    final useSystemMode = await _settingsRepository.getUseSystemMode();
    final darkMode = await _settingsRepository.getDarkMode();

    emit(
      state.copyWith(
        settings: Settings(
          useSystemTheme: useSystemMode,
          darkMode: darkMode,
        ),
      ),
    );
  }

  Future<void> setUseSystemTheme({required bool useSystemMode}) async {
    await _settingsRepository.setUseSystemMode(useSystemMode: useSystemMode);
    emit(
      state.copyWith(
        settings: state.settings?.copyWith(
          useSystemTheme: await _settingsRepository.getUseSystemMode(),
        ),
      ),
    );
  }

  Future<void> setDarkMode({required bool darkMode}) async {
    await _settingsRepository.setDarkMode(darkMode: darkMode);
    emit(
      state.copyWith(
        settings: state.settings?.copyWith(
          darkMode: await _settingsRepository.getDarkMode(),
        ),
      ),
    );
  }
}
