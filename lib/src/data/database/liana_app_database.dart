import 'dart:async';
import 'package:floor/floor.dart';
import 'package:liana/src/data/datasource/folders_datasource.dart';
import 'package:liana/src/data/datasource/modules_datasource.dart';
import 'package:liana/src/data/entity/folder_dto.dart';
import 'package:liana/src/data/entity/module_dto.dart';
import 'package:sqflite/sqflite.dart' as sqflite;

part 'liana_app_database.g.dart';

@Database(
  version: 1,
  entities: [
    FolderDto,
    ModuleDto,
  ],
)
abstract class LianaAppDatabase extends FloorDatabase {
  FoldersDatasource get foldersDatasource;
  ModulesDatasource get modulesDatasource;
}
