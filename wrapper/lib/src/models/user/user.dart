import 'package:wrapper/src/http/managers/user_manager.dart';
import 'package:wrapper/src/models/identified_entity/identified_entity.dart';

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
  final String accountVisiblity;
  // final List<dynamic> more;
  // final String username;
  // final String imageKey;
  // final List<dynamic> userSchools;
  // String? jobTitle;
  final String email;
  // final String role;
  // final dynamic notificationPreferences;
  // final String firstName;
  // final String stories;
  // final String businessName;
  // final String meta;
  // final String openTo;
  // final int profileScore;
  // final String? contactEmail;
  // final String? phoneNumber;
  // final List<dynamic> userBadges;

  User({
    required super.id,
    required super.manager,
    required this.permissions,
    required this.accountStatus,
    required this.accountVisiblity,
    required this.email,
    required this.lastName,
  });
}
