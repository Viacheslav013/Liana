import 'package:floor/floor.dart';
import 'package:liana/src/data/entity/folder_dto.dart';

@dao
abstract class FoldersDatasource {
  @Query('SELECT * FROM Folder')
  Stream<List<FolderDto>> getAllFolders();

  @insert
  Future<void> createFolder(FolderDto folder);

  @update
  Future<void> updateFolder(FolderDto folder);

  @delete
  Future<void> deleteFolder(FolderDto folder);
}
