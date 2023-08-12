import 'package:liana/src/domain/entity/module.dart';

abstract class ModulesRepository {
  Stream<List<Module>> getModulesByFolderId(int folderId);

  Future<void> createModule(Module module);

  Future<void> updateModule(Module module);

  Future<void> deleteModule(Module module);
}
