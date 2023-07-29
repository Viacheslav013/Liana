import 'package:injectable/injectable.dart';
import 'package:liana/src/data/datasource/folders_datasource.dart';
import 'package:liana/src/data/mappers/folders_mapper.dart';
import 'package:liana/src/domain/entity/folder.dart';
import 'package:liana/src/domain/repository/folders_repository.dart';

@Injectable(as: FoldersRepository)
class FoldersRepositoryImpl implements FoldersRepository {
  const FoldersRepositoryImpl(
    this.foldersDatasource,
    this.folderToDtoMapper,
    this.dtoToFolderMapper,
  );

  final FoldersDatasource foldersDatasource;
  final FolderToDtoMapper folderToDtoMapper;
  final DtoToFolderMapper dtoToFolderMapper;

  @override
  Stream<List<Folder>> getAllFolders() {
    return foldersDatasource
      .getAllFolders()
      .map((folders) => folders.map(dtoToFolderMapper.map).toList());
  }

  @override
  Future<void> createFolder(Folder folder) async {
    await foldersDatasource.createFolder(folderToDtoMapper.map(folder));
  }

  @override
  Future<void> updateFolder(Folder folder) async {
    await foldersDatasource.updateFolder(folderToDtoMapper.map(folder));
  }

  @override
  Future<void> deleteFolder(Folder folder) async {
    await foldersDatasource.deleteFolder(folderToDtoMapper.map(folder));
  }
}
