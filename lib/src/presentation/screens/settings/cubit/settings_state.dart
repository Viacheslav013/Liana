import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:liana/src/domain/entity/settings.dart';

part 'settings_state.freezed.dart';

@freezed
class SettingsState with _$SettingsState {
  const factory SettingsState({
    Settings? settings,
  }) = _SettingsState;
}
