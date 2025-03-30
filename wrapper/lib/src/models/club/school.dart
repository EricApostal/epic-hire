import 'package:wrapper/src/http/managers/school_manager.dart';
import 'package:wrapper/src/models/identified_entity/identified_entity.dart';

class PartialSchool extends ManagedIdentifiedEntity<School> {
  @override
  final SchoolManager manager;

  PartialSchool({required super.id, required this.manager});
}

class School extends PartialSchool {
  final String abbreviation;
  final bool isHbcu;
  final String name;
  final String state;

  School({
    required super.id,
    required super.manager,
    required this.name,
    required this.abbreviation,
    required this.state,
    required this.isHbcu,
  });
}
