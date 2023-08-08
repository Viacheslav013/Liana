import 'package:injectable/injectable.dart';
import 'package:liana/src/data/database/liana_app_database.dart';
import 'package:liana/src/data/datasource/folders_datasource.dart';
import 'package:liana/src/data/datasource/modules_datasource.dart';
import 'package:liana/src/data/datasource/terms_and_definitions_datasource.dart';
import 'package:liana/src/domain/entity/term_and_definition.dart';

const m = <TermAndDefinition, int>{};

const _dbFileName = 'liana_app_database.db';

@module
abstract class DatasourceModule {
  @preResolve
  @singleton
  Future<LianaAppDatabase> provideLianaAppDatabase() =>
      $FloorLianaAppDatabase.databaseBuilder(_dbFileName).build();

  @singleton
  FoldersDatasource provideFoldersDatasource(LianaAppDatabase database) =>
      database.foldersDatasource;

  @singleton
  ModulesDatasource provideModulesDatasource(LianaAppDatabase database) =>
      database.modulesDatasource;

  @singleton
  TermsAndDefinitionsDatasource provideTermsAndDefinitionsDatasource(
    LianaAppDatabase database,
  ) =>
      database.termsAndDefinitionsDatasource;
}
