import 'package:floor/floor.dart';

@DatabaseView(
  'SELECT m.id, m.name, m.folderId, count(t.id) as numberOfTermsAndDefinitions '
  'FROM Module m LEFT JOIN TermAndDefinition t on m.id = t.moduleId '
  'GROUP BY m.id',
)
class ModuleView {
  const ModuleView({
    required this.id,
    required this.name,
    required this.folderId,
    required this.numberOfTermsAndDefinitions,
  });

  final int? id;
  final String name;
  final int folderId;
  final int numberOfTermsAndDefinitions;
}
