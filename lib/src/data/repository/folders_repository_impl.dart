import 'package:injectable/injectable.dart';
import 'package:liana/src/data/datasource/folders_datasource.dart';
import 'package:liana/src/data/mappers/folders_mapper.dart';
import 'package:liana/src/domain/entity/folder.dart';
import 'package:liana/src/domain/repository/folders_repository.dart';

@Injectable(as: FoldersRepository)
class FoldersRepositoryImpl implements FoldersRepository {
  const FoldersRepositoryImpl(
    this._foldersDatasource,
    this._folderToDtoMapper,
    this._dtoToFolderMapper,
  );

  final FoldersDatasource _foldersDatasource;
  final FolderToDtoMapper _folderToDtoMapper;
  final DtoToFolderMapper _dtoToFolderMapper;

  @override
  Stream<List<Folder>> getAllFolders() {
    return _foldersDatasource
        .getAllFolders()
        .map((folders) => folders.map(_dtoToFolderMapper.map).toList());
  }

  @override
  Future<void> createFolder(Folder folder) async {
    await _foldersDatasource.createFolder(_folderToDtoMapper.map(folder));
  }

  @override
  Future<void> updateFolder(Folder folder) async {
    await _foldersDatasource.updateFolder(_folderToDtoMapper.map(folder));
  }

  @override
  Future<void> deleteFolder(Folder folder) async {
    await _foldersDatasource.deleteFolder(_folderToDtoMapper.map(folder));
  }
}
