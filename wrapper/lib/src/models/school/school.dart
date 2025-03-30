import 'package:wrapper/src/http/managers/school_manager.dart';
import 'package:wrapper/src/models/identified_entity/identified_entity.dart';

class PartialSchool extends ManagedIdentifiedEntity<School> {
  @override
  final SchoolManager manager;

  PartialSchool({required super.id, required this.manager});
}

class School extends PartialSchool {
  final String? mongoObjectId;
  final String name;
  final String state;
  final String abbreviation;
  final dynamic conference;
  final dynamic location;
  final bool hbcu;

  School({
    required super.id,
    required super.manager,
    required this.mongoObjectId,
    required this.name,
    required this.state,
    required this.abbreviation,
    this.conference,
    this.location,
    required this.hbcu,
  });
}
