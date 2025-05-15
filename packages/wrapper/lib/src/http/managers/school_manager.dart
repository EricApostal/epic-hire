import 'package:wrapper/src/http/managers/manager.dart';
import 'package:wrapper/src/models/school/school.dart';
import 'package:wrapper/src/models/identified.dart';
import 'package:wrapper/src/models/identified_entity/identified_entity.dart';
import 'package:wrapper/src/models/user/user.dart';

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
      mongoObjectId: raw["mongoObjectId"] as String?,
      name: raw["name"] as String,
      state: raw["state"] as String,
      abbreviation: raw["abbreviation"] as String,
      conference: raw["conference"],
      location: raw["location"],
      hbcu: raw["hbcu"] as bool? ?? false,
    );
  }

  UserSchool parseUserSchool(Map<String, Object?> raw) {
    return UserSchool(
      id: Identified(raw["id"] as int),
      school: parse(raw["school"] as Map<String, Object?>),
      graduationYear: raw["graduationYear"] as int,
      adHocSchoolName: raw["adHocSchoolName"] as String?,
    );
  }
}
