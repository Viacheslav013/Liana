import 'package:floor/floor.dart';
import 'package:liana/src/data/entity/module_dto.dart';

@dao
abstract class ModulesDatasource {

  @Query('SELECT * FROM Module WHERE folderId = :folderId')
  Stream<List<ModuleDto>> getModulesByFolderId(int folderId);

  @insert
  Future<void> createModule(ModuleDto module);

  @update
  Future<void> updateModule(ModuleDto module);

  @delete
  Future<void> deleteModule(ModuleDto module);
}
