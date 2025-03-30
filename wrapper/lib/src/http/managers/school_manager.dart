import 'package:wrapper/src/http/managers/manager.dart';
import 'package:wrapper/src/models/club/school.dart';
import 'package:wrapper/src/models/identified.dart';
import 'package:wrapper/src/models/identified_entity/identified_entity.dart';

class SchoolManager extends ReadOnlyManager<School> {
  /// Create a new [CompanyManager].
  SchoolManager(super.config, super.client) : super(identifier: 'schools');

  @override
  ManagedIdentifiedEntity<School> operator [](Identified id) {
    // TODO: implement []
    throw UnimplementedError();
  }

  @override
  Future<School> fetch(Identified id) {
    // TODO: implement fetch
    throw UnimplementedError();
  }

  @override
  School parse(Map<String, Object?> raw) {
    return School(
      manager: this,
      id: Identified(raw["id"] as int),
      abbreviation: raw["abbreviation"] as String,
      name: raw["name"] as String,
      state: raw["state"] as String,
      isHbcu: raw["isHbcu"] as bool,
    );
  }
}
