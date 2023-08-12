import 'package:injectable/injectable.dart';
import 'package:liana/src/data/entity/folder_dto.dart';
import 'package:liana/src/data/mappers/base_mapper.dart';
import 'package:liana/src/domain/entity/folder.dart';

@injectable
class FolderToDtoMapper implements BaseMapper<Folder, FolderDto> {
  @override
  FolderDto map(Folder from) {
    return FolderDto(id: from.id, name: from.name);
  }
}

@injectable
class DtoToFolderMapper implements BaseMapper<FolderDto, Folder> {
  @override
  Folder map(FolderDto from) {
    return Folder(id: from.id, name: from.name);
  }
}
