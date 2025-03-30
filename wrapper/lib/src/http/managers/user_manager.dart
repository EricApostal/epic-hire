import 'package:wrapper/src/http/managers/manager.dart';
import 'package:wrapper/src/http/request.dart';
import 'package:wrapper/src/http/route.dart';
import 'package:wrapper/src/models/identified.dart';
import 'package:wrapper/src/models/identified_entity/identified_entity.dart';
import 'package:wrapper/src/models/user/user.dart';
import 'package:wrapper/src/utils/cache_helpers.dart';
import 'package:wrapper/src/utils/parsing_helpers.dart';

/// A manager for [User]s.
class UserManager extends ReadOnlyManager<User> {
  /// Create a new [UserManager].
  UserManager(super.config, super.client) : super(identifier: 'users');

  @override
  User parse(Map<String, Object?> raw) {
    return User(
      manager: this,
      id: Identified(raw["id"] as int),
      permissions: raw["permissions"] as List<dynamic>,
      lastName: raw["lastName"] as String,
      accountStatus: raw["accountStatus"] as String,
      accountVisiblity: raw["accountVisiblity"] as String?,
      email: raw["email"] as String,
      username: raw["username"] as String,
      imageKey: raw["imageKey"] as String,
      userSchools: parseMany(
        raw["userSchools"] as List<dynamic>,
        client.schools.parseUserSchool,
      ),
      role: raw["role"] as String,
      notificationPreferences: raw["notificationPreferences"],
      firstName: raw["firstName"] as String,
      stories: raw["stories"] as List<dynamic>,
      businessName: raw["businessName"] as String?,
      meta: raw["meta"] as Map<String, dynamic>?,
      openTo: raw["openTo"] as List<dynamic>,
      profileScore: (raw["profileScore"] as int),
      userBadges: raw["userBadges"] as List<dynamic>,
      more: raw["more"] as List<dynamic>,
    );
  }

  @override
  ManagedIdentifiedEntity<User> operator [](Identified id) {
    // TODO: implement []
    throw UnimplementedError();
  }

  @override
  Future<User> fetch(Identified id) {
    // TODO: implement fetch
    throw UnimplementedError();
  }

  /// Fetch the current user from the API.
  Future<User> fetchCurrentUser() async {
    final route = HttpRoute()..users(id: client.apiOptions.userId.toString());
    final request = BasicRequest(route, 2);

    final response = await client.httpHandler.executeSafe(request);
    final user = parse(response.jsonBody as Map<String, Object?>);

    client.updateCacheWith(user);
    return user;
  }
}
