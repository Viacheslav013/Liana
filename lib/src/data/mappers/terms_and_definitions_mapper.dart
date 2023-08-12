import 'package:injectable/injectable.dart';
import 'package:liana/src/data/entity/term_and_definition_dto.dart';
import 'package:liana/src/data/mappers/base_mapper.dart';
import 'package:liana/src/domain/entity/term_and_definition.dart';

@injectable
class TermAndDefinitionToDtoMapper
    implements BaseMapper<TermAndDefinition, TermAndDefinitionDto> {
  @override
  TermAndDefinitionDto map(TermAndDefinition from) {
    return TermAndDefinitionDto(
      id: from.id,
      term: from.term,
      definition: from.definition,
      isFavorite: from.isFavorite,
      moduleId: from.moduleId,
    );
  }
}

@injectable
class DtoToTermAndDefinitionMapper
    implements BaseMapper<TermAndDefinitionDto, TermAndDefinition> {
  @override
  TermAndDefinition map(TermAndDefinitionDto from) {
    return TermAndDefinition(
      id: from.id,
      term: from.term,
      definition: from.definition,
      isFavorite: from.isFavorite,
      moduleId: from.moduleId,
    );
  }
}
