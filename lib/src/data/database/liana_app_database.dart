import 'dart:async';
import 'package:floor/floor.dart';
import 'package:liana/src/data/datasource/folders_datasource.dart';
import 'package:liana/src/data/datasource/modules_datasource.dart';
import 'package:liana/src/data/datasource/terms_and_definitions_datasource.dart';
import 'package:liana/src/data/entity/folder_dto.dart';
import 'package:liana/src/data/entity/module_dto.dart';
import 'package:liana/src/data/entity/module_view.dart';
import 'package:liana/src/data/entity/term_and_definition_dto.dart';
import 'package:sqflite/sqflite.dart' as sqflite;

part 'liana_app_database.g.dart';

@Database(
  version: 1,
  entities: [
    FolderDto,
    ModuleDto,
    TermAndDefinitionDto,
  ],
  views: [
    ModuleView,
  ],
)
abstract class LianaAppDatabase extends FloorDatabase {
  FoldersDatasource get foldersDatasource;
  ModulesDatasource get modulesDatasource;
  TermsAndDefinitionsDatasource get termsAndDefinitionsDatasource;
}
