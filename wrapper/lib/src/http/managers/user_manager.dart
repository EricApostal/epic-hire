import 'package:wrapper/src/http/managers/manager.dart';
import 'package:wrapper/src/http/request.dart';
import 'package:wrapper/src/http/route.dart';
import 'package:wrapper/src/models/identified.dart';
import 'package:wrapper/src/models/identified_entity/identified_entity.dart';
import 'package:wrapper/src/models/user/user.dart';
import 'package:wrapper/src/utils/cache_helpers.dart';

/// A manager for [User]s.
class UserManager extends ReadOnlyManager<User> {
  /// Create a new [UserManager].
  UserManager(super.config, super.client) : super(identifier: 'users');

  @override
  User parse(Map<String, Object?> raw) {
    return User(
      manager: this,
      id: Identified.parse(raw["id"] as int),
      permissions: raw["permissions"] as List<dynamic>,
      lastName: raw["lastName"] as String,
      accountStatus: raw["accountStatus"] as String,
      accountVisiblity: raw["accountVisibility"] as String,
      email: raw["email"] as String,
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
    // TODO: Don't hard code
    final route = HttpRoute()..users(id: '20256');
    final request = BasicRequest(route);

    final response = await client.httpHandler.executeSafe(request);
    final user = parse(response.jsonBody as Map<String, Object?>);

    client.updateCacheWith(user);
    return user;
  }
}
