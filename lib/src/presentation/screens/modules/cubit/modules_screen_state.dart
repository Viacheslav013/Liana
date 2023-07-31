import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:liana/src/domain/entity/module.dart';

part 'modules_screen_state.freezed.dart';

@freezed
class ModulesScreenState with _$ModulesScreenState {
  const factory ModulesScreenState({
    @Default([]) List<Module> modules,
    @Default(true) bool isLoading,
    String? error,
  }) = _ModulesScreenState;
}
