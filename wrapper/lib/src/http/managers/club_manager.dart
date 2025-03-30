import 'package:wrapper/src/http/managers/manager.dart';
import 'package:wrapper/src/http/request.dart';
import 'package:wrapper/src/http/route.dart';
import 'package:wrapper/src/models/club/club.dart';
import 'package:wrapper/src/models/identified.dart';
import 'package:wrapper/src/models/identified_entity/identified_entity.dart';
import 'package:wrapper/src/utils/cache_helpers.dart';
import 'package:wrapper/src/utils/parsing_helpers.dart';

class ClubManager extends ReadOnlyManager<Club> {
  /// Create a new [CompanyManager].
  ClubManager(super.config, super.client) : super(identifier: 'clubs');

  @override
  ManagedIdentifiedEntity<Club> operator [](Identified id) {
    // TODO: implement []
    throw UnimplementedError();
  }

  @override
  Future<Club> fetch(Identified id) {
    // TODO: implement fetch
    throw UnimplementedError();
  }

  @override
  Club parse(Map<String, Object?> raw) {
    return Club(
      manager: this,
      id: Identified(raw["id"] as int),
      name: raw["name"] as String,
      description: raw["description"] as String?,
      published: raw["published"] as bool,
      featured: raw["featured"] as bool,
      // this definitely should't be nullable, but I'm *guessing* that null means it pre-dates this addition?
      hasNewUi: raw["hasNewUi"] as bool? ?? false,
      created: DateTime.parse(raw["created"] as String),
      isNational: raw["isNational"] as bool,
      tags: raw["tags"] as List<dynamic>,
      memberProfilePictureKeys:
          (raw["memberProfilePictureKeys"] as List<dynamic>)
              .map((e) => e as String)
              .toList(),
      schools: parseMany(raw["schools"] as List<dynamic>, client.schools.parse),
    );
  }

  Future<List<Club>> fetchPage(int page, {int? limit}) async {
    final route =
        HttpRoute()
          ..public()
          ..clubs()
          ..search();

    final request = BasicRequest(
      route,
      2,
      queryParameters: {
        "page": page.toString(),
        if (limit != null) "limit": limit.toString(),
      },
    );

    final response = await client.httpHandler.executeSafe(request);
    final clubs = parseMany(
      (response.jsonBody as Map<String, dynamic>)["data"] as List<dynamic>,
      (e) {
        return parse(e as Map<String, Object?>);
      },
    );

    clubs.forEach(client.updateCacheWith);
    return clubs;
  }
}
