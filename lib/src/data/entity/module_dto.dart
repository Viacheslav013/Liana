import 'package:floor/floor.dart';
import 'package:liana/src/data/entity/folder_dto.dart';

@Entity(
  tableName: 'Module',
  foreignKeys: [
    ForeignKey(
      entity: FolderDto,
      parentColumns: ['id'],
      childColumns: ['folderId'],
      onUpdate: ForeignKeyAction.cascade,
      onDelete: ForeignKeyAction.cascade,
    ),
  ],
)
class ModuleDto {
  const ModuleDto({
    required this.id,
    required this.name,
    required this.folderId,
  });

  @PrimaryKey(autoGenerate: true)
  final int? id;
  final String name;
  final int folderId;
}
