import 'package:injectable/injectable.dart' as injectable;
import 'package:liana/src/data/entity/module_dto.dart';
import 'package:liana/src/data/entity/module_view.dart';
import 'package:liana/src/data/mappers/base_mapper.dart';
import 'package:liana/src/domain/entity/module.dart';

@injectable.injectable
class ModuleToDtoMapper implements BaseMapper<Module, ModuleDto> {
  @override
  ModuleDto map(Module from) {
    return ModuleDto(
      id: from.id,
      name: from.name,
      folderId: from.folderId,
    );
  }
}

@injectable.injectable
class ViewToModuleMapper implements BaseMapper<ModuleView, Module> {
  @override
  Module map(ModuleView from) {
    return Module(
      id: from.id,
      name: from.name,
      folderId: from.folderId,
      numberOfTermsDefinitions: from.numberOfTermsAndDefinitions,
    );
  }
}
