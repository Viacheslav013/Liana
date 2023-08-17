import 'package:injectable/injectable.dart';
import 'package:liana/src/data/datasource/terms_and_definitions_datasource.dart';
import 'package:liana/src/data/mappers/terms_and_definitions_mapper.dart';
import 'package:liana/src/domain/entity/term_and_definition.dart';
import 'package:liana/src/domain/repository/terms_and_definitions_repository.dart';

@Injectable(as: TermsAndDefinitionsRepository)
class TermsAndDefinitionsRepositoryImpl
    implements TermsAndDefinitionsRepository {
  const TermsAndDefinitionsRepositoryImpl(
    this._termsAndDefinitionsDatasource,
    this._termAndDefinitionToDtoMapper,
    this._dtoToTermAndDefinitionMapper,
  );

  final TermsAndDefinitionsDatasource _termsAndDefinitionsDatasource;
  final TermAndDefinitionToDtoMapper _termAndDefinitionToDtoMapper;
  final DtoToTermAndDefinitionMapper _dtoToTermAndDefinitionMapper;

  @override
  Stream<List<TermAndDefinition>> getTermsAndDefinitionsByModuleId(
    int moduleId,
  ) =>
      _termsAndDefinitionsDatasource
          .getTermsAndDefinitionsByModuleId(moduleId)
          .map(
            (termsAndDefinitions) => termsAndDefinitions
                .map(_dtoToTermAndDefinitionMapper.map)
                .toList(),
          );

  @override
  Stream<List<TermAndDefinition>> getFavoriteTermsAndDefinitions() =>
      _termsAndDefinitionsDatasource.getFavoriteTermsAndDefinitions().map(
            (termsAndDefinitions) => termsAndDefinitions
                .map(_dtoToTermAndDefinitionMapper.map)
                .toList(),
          );

  @override
  Future<void> createTermAndDefinition(
    TermAndDefinition termAndDefinition,
  ) async {
    await _termsAndDefinitionsDatasource.createTermAndDefinition(
      _termAndDefinitionToDtoMapper.map(termAndDefinition),
    );
  }

  @override
  Future<void> updateTermAndDefinition(
    TermAndDefinition termAndDefinition,
  ) async {
    await _termsAndDefinitionsDatasource.updateTermAndDefinition(
      _termAndDefinitionToDtoMapper.map(termAndDefinition),
    );
  }

  @override
  Future<void> deleteTermAndDefinition(
    TermAndDefinition termAndDefinition,
  ) async {
    await _termsAndDefinitionsDatasource.deleteTermAndDefinition(
      _termAndDefinitionToDtoMapper.map(termAndDefinition),
    );
  }
}
