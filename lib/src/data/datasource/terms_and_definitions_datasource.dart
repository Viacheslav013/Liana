import 'package:floor/floor.dart';
import 'package:liana/src/data/entity/term_and_definition_dto.dart';

@dao
abstract class TermsAndDefinitionsDatasource {
  @Query('SELECT * FROM TermAndDefinition WHERE moduleId = :moduleId')
  Stream<List<TermAndDefinitionDto>> getTermsAndDefinitionsByModuleId(
    int moduleId,
  );

  @insert
  Future<void> createTermAndDefinition(TermAndDefinitionDto termAndDefinition);

  @update
  Future<void> updateTermAndDefinition(TermAndDefinitionDto termAndDefinition);

  @delete
  Future<void> deleteTermAndDefinition(TermAndDefinitionDto termAndDefinition);
}