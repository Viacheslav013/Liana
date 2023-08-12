import 'package:floor/floor.dart';
import 'package:liana/src/data/entity/module_dto.dart';
import 'package:liana/src/data/entity/module_view.dart';

@dao
abstract class ModulesDatasource {
  @Query('SELECT * FROM ModuleView WHERE folderId = :folderId')
  Stream<List<ModuleView>> getModulesByFolderId(int folderId);

  @insert
  Future<void> createModule(ModuleDto module);

  @update
  Future<void> updateModule(ModuleDto module);

  @delete
  Future<void> deleteModule(ModuleDto module);
}
