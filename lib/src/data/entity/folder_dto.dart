import 'package:floor/floor.dart';

@Entity(tableName: 'Folder')
class FolderDto {
  const FolderDto(this.id, this.name);

  @PrimaryKey(autoGenerate: true)
  final int? id;
  final String name;
}
