import 'package:floor/floor.dart';
import 'package:liana/src/data/entity/module_dto.dart';

@Entity(
  tableName: 'TermAndDefinition',
  foreignKeys: [
    ForeignKey(
      entity: ModuleDto,
      parentColumns: ['id'],
      childColumns: ['moduleId'],
      onUpdate: ForeignKeyAction.cascade,
      onDelete: ForeignKeyAction.cascade,
    ),
  ],
)
class TermAndDefinitionDto {
  const TermAndDefinitionDto({
    required this.id,
    required this.term,
    required this.definition,
    required this.isFavorite,
    required this.moduleId,
  });

  @PrimaryKey(autoGenerate: true)
  final int? id;
  final String term;
  final String definition;
  final bool isFavorite;
  final int moduleId;
}
