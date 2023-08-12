import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:liana/src/domain/entity/term_and_definition.dart';

part 'terms_and_definitions_screen_state.freezed.dart';

@freezed
class TermsAndDefinitionsScreenState with _$TermsAndDefinitionsScreenState {
  const factory TermsAndDefinitionsScreenState({
    @Default([]) List<TermAndDefinition> termsAndDefinitions,
    @Default(true) bool isLoading,
    String? error,
  }) = _TermsAndDefinitionsScreenState;
}
