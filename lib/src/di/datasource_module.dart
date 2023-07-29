import 'package:injectable/injectable.dart';
import 'package:liana/src/data/database/liana_app_database.dart';
import 'package:liana/src/data/datasource/folders_datasource.dart';

const _dbFileName = 'liana_app_database.db';

@module
abstract class DatasourceModule {

  @preResolve
  Future<LianaAppDatabase> provideLianaAppDatabase() =>
    $FloorLianaAppDatabase.databaseBuilder(_dbFileName).build();

  @singleton
  FoldersDatasource provideFoldersDatasource(LianaAppDatabase database) =>
    database.foldersDatasource;
}
