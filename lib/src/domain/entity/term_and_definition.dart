import 'package:freezed_annotation/freezed_annotation.dart';

part 'term_and_definition.freezed.dart';

@freezed
class TermAndDefinition with _$TermAndDefinition {
  const factory TermAndDefinition({
    required int? id,
    required String term,
    required String definition,
    required bool isFavorite,
    required int moduleId,
  }) = _TermAndDefinition;
}
