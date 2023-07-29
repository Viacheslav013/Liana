import 'package:liana/src/domain/entity/folder.dart';

abstract class FoldersRepository {

  Stream<List<Folder>> getAllFolders();

  Future<void> createFolder(Folder folder);

  Future<void> updateFolder(Folder folder);

  Future<void> deleteFolder(Folder folder);
}
