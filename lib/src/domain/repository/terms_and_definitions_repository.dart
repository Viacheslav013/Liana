import 'package:liana/src/domain/entity/term_and_definition.dart';

abstract class TermsAndDefinitionsRepository {
  Stream<List<TermAndDefinition>> getTermsAndDefinitionsByModuleId(
    int moduleId,
  );

  Future<void> createTermAndDefinition(TermAndDefinition termAndDefinition);

  Future<void> updateTermAndDefinition(TermAndDefinition termAndDefinition);

  Future<void> deleteTermAndDefinition(TermAndDefinition termAndDefinition);
}