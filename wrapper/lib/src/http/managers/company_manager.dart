import 'package:wrapper/src/http/managers/manager.dart';
import 'package:wrapper/src/http/request.dart';
import 'package:wrapper/src/http/route.dart';
import 'package:wrapper/src/models/company/company.dart';
import 'package:wrapper/src/models/identified.dart';
import 'package:wrapper/src/models/identified_entity/identified_entity.dart';
import 'package:wrapper/src/utils/cache_helpers.dart';
import 'package:wrapper/src/utils/parsing_helpers.dart';

/// A manager for [User]s.
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
      id: Identified(raw["id"] as int),
      name: raw["name"] as String,
      permissions: raw["permissions"] as List<dynamic>,
      published: raw["published"] as bool,
      weight: raw["weight"] as int,
      hires: raw["hires"] as int,
      followers: raw["followers"] as int,
      jobCategories: raw["jobCategories"] as List<dynamic>,
    );
  }

  Future<List<Company>> fetchCompanyPages() async {
    final route =
        HttpRoute()
          ..public()
          ..companyPages()
          ..search();
    final request = BasicRequest(route, 1);

    final response = await client.httpHandler.executeSafe(request);
    final companies = parseMany(response.jsonBody as List<dynamic>, (e) {
      return parse(e as Map<String, Object?>);
    });

    // companies.forEach(client.updateCacheWith);
    return companies;
  }
}
