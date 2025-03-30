import 'package:wrapper/src/http/managers/user_manager.dart';
import 'package:wrapper/src/models/company/story.dart';
import 'package:wrapper/src/models/identified_entity/identified_entity.dart';
import 'package:wrapper/src/models/school/school.dart';

/// A partial [User] object.
class PartialUser extends ManagedIdentifiedEntity<User> {
  @override
  final UserManager manager;

  /// Create a new [PartialUser].
  /// @nodoc
  PartialUser({required super.id, required this.manager});
}

class User extends PartialUser {
  final List<dynamic> permissions;
  final String lastName;
  final String accountStatus;
  final String? accountVisiblity;
  final List<dynamic> more;
  final String username;
  final String? imageKey;
  final List<UserSchool> userSchools;
  String? jobTitle;
  final String email;
  final String role;
  final dynamic notificationPreferences;
  final String firstName;
  final List<Story> stories;
  final String? businessName;
  final Map<String, dynamic>? meta;
  final List<dynamic> openTo;
  final int profileScore;
  final String? contactEmail;
  final String? phoneNumber;
  final List<dynamic> userBadges;

  User({
    required super.id,
    required super.manager,
    required this.permissions,
    required this.accountStatus,
    this.accountVisiblity,
    required this.email,
    required this.lastName,
    required this.username,
    this.imageKey,
    required this.userSchools,
    required this.role,
    required this.notificationPreferences,
    required this.firstName,
    required this.stories,
    this.businessName,
    this.meta,
    required this.openTo,
    required this.profileScore,
    required this.userBadges,
    required this.more,
    this.contactEmail,

    this.phoneNumber,
  });
}

class UserSchool extends IdentifiedEntity<User> {
  final int graduationYear;
  final String? adHocSchoolName;
  final School school;

  /// Create a new [UserSchool].
  UserSchool({
    required super.id,
    required this.school,
    required this.graduationYear,
    this.adHocSchoolName,
  }) : assert(
         graduationYear > 1900 && graduationYear < 2100,
         'Graduation year must be between 1900 and 2100',
       );

  @override
  String toString() => 'UserSchool(id: $id, school: $school)';

  @override
  Future<User> fetch() {
    // TODO: implement fetch
    throw UnimplementedError();
  }

  @override
  Future<User> get() {
    // TODO: implement get
    throw UnimplementedError();
  }
}
