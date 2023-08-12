import 'package:injectable/injectable.dart' as injectable;
import 'package:liana/src/data/datasource/modules_datasource.dart';
import 'package:liana/src/data/mappers/modules_mapper.dart';
import 'package:liana/src/domain/entity/module.dart';
import 'package:liana/src/domain/repository/modules_repository.dart';

@injectable.Injectable(as: ModulesRepository)
class ModulesRepositoryImpl implements ModulesRepository {
  const ModulesRepositoryImpl(
    this._modulesDatasource,
    this._moduleToDtoMapper,
    this._viewToModuleMapper,
  );

  final ModulesDatasource _modulesDatasource;
  final ModuleToDtoMapper _moduleToDtoMapper;
  final ViewToModuleMapper _viewToModuleMapper;

  @override
  Stream<List<Module>> getModulesByFolderId(int folderId) {
    return _modulesDatasource
        .getModulesByFolderId(folderId)
        .map((modules) => modules.map(_viewToModuleMapper.map).toList());
  }

  @override
  Future<void> createModule(Module module) async {
    await _modulesDatasource.createModule(_moduleToDtoMapper.map(module));
  }

  @override
  Future<void> updateModule(Module module) async {
    await _modulesDatasource.updateModule(_moduleToDtoMapper.map(module));
  }

  @override
  Future<void> deleteModule(Module module) async {
    await _modulesDatasource.deleteModule(_moduleToDtoMapper.map(module));
  }
}
