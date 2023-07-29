import 'package:floor/floor.dart';

@Entity(tableName: 'Folder')
class FolderDto {
  FolderDto(this.id, this.name);

  @PrimaryKey(autoGenerate: true)
  int? id;
  String name;
}
