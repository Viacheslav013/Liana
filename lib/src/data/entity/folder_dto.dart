import 'package:floor/floor.dart';

@Entity(tableName: 'Folder')
class FolderDto {
  const FolderDto({required this.id, required this.name});

  @PrimaryKey(autoGenerate: true)
  final int? id;
  final String name;
}
