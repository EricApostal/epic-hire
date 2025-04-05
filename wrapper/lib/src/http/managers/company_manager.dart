import 'package:wrapper/src/http/managers/manager.dart';
import 'package:wrapper/src/http/request.dart';
import 'package:wrapper/src/http/route.dart';
import 'package:wrapper/src/models/company/company.dart';
import 'package:wrapper/src/models/story/story.dart';
import 'package:wrapper/src/models/identified.dart';
import 'package:wrapper/src/models/identified_entity/identified_entity.dart';
import 'package:wrapper/src/utils/cache_helpers.dart';
import 'package:wrapper/src/utils/parsing_helpers.dart';

/// A manager for [Company]s.
class CompanyManager extends ReadOnlyManager<Company> {
  /// Create a new [CompanyManager].
  CompanyManager(super.config, super.client) : super(identifier: 'companies');

  @override
  ManagedIdentifiedEntity<Company> operator [](Identified id) {
    // TODO: implement []
    throw UnimplementedError();
  }

  @override
  Future<Company> fetch(Identified id) {
    // TODO: implement fetch
    throw UnimplementedError();
  }

  @override
  Company parse(Map<String, Object?> raw) {
    return Company(
      manager: this,
      name: raw["name"] as String,
      permissions: List<String>.from(raw["permissions"] as List),
      id: Identified(raw["id"] as int),
      website: raw["website"] as String,
      imageKey: raw["imageKey"] as String,
      schools: parseMany(
        raw["colleges"] as List<dynamic>,
        (e) => client.schools.parse(e as Map<String, Object?>),
      ),
      nationalVisibility: raw["nationalVisibility"] as bool,
      highlights: parseMany(
        raw["highlights"] as List<dynamic>,
        (e) => client.jobs.parseJobHighlight(e as Map<String, Object?>),
      ),
      published: raw["published"] as bool,
      weight: raw["weight"] as int,
      followers: raw["followers"] as int,
      stories: parseMany(
        raw["stories"] as List<dynamic>,
        (e) => client.stories.parse(e as Map<String, Object?>),
      ),
      jobCategories: parseMany(
        raw["jobCategories"] as List<dynamic>,
        (e) => client.jobs.parseJobCategory(e as Map<String, Object?>),
      ),
      locations: parseMany(
        raw["locations"] as List<dynamic>,
        (e) => client.jobs.parseLocation(e as Map<String, Object?>),
      ),
      more: List<dynamic>.from(raw["more"] as List),
      hires: raw["hires"] as int,
      industry: raw["industry"],
      userBadges: List<dynamic>.from(raw["userBadges"] as List),
      signedInUserIsAdmin: raw["signedInUserIsAdmin"] as bool,
    );
  }

  Future<List<Company>> fetchCompanyPages() async {
    final route =
        HttpRoute()
          ..public()
          ..companyPages()
          ..search();
    final request = BasicRequest(route, 1, queryParameters: {"limit": "4"});

    final response = await client.httpHandler.executeSafe(request);
    final companies = parseMany(response.jsonBody as List<dynamic>, (e) {
      return parse(e as Map<String, Object?>);
    });

    companies.forEach(client.updateCacheWith);
    return companies;
  }
}
