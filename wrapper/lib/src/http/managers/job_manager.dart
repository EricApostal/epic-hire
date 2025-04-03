import 'package:wrapper/src/http/managers/manager.dart';
import 'package:wrapper/src/http/request.dart';
import 'package:wrapper/src/http/route.dart';
import 'package:wrapper/src/models/identified.dart';
import 'package:wrapper/src/models/identified_entity/identified_entity.dart';
import 'package:wrapper/src/models/job/category.dart';
import 'package:wrapper/src/models/job/family.dart';
import 'package:wrapper/src/models/job/highlight.dart';
import 'package:wrapper/src/models/job/job.dart';
import 'package:wrapper/src/models/job/location.dart';
import 'package:wrapper/src/models/job/media.dart';
import 'package:wrapper/src/models/job/reaction.dart';
import 'package:wrapper/src/utils/parsing_helpers.dart';

class JobManager extends ReadOnlyManager<Job> {
  /// Create a new [CompanyManager].
  JobManager(super.config, super.client) : super(identifier: 'schools');

  JobFamily parseFamily(Map<String, Object?> raw) {
    return JobFamily(id: raw["id"] as int, name: raw["name"] as String);
  }

  JobCategory parseJobCategory(Map<String, Object?> raw) {
    return JobCategory(
      id: raw["id"] as int,
      mongoObjectId: raw["mongoObjectId"] as String?,
      name: raw["name"] as String,
      imageKey: raw["imageKey"] as String,
      family: parseFamily(raw["family"] as Map<String, Object?>),
      playbookTags: List<String>.from(raw["playbookTags"] as List),
    );
  }

  Location parseLocation(Map<String, Object?> raw) {
    return Location(
      id: raw["id"] as int,
      locationName: raw["locationName"] as String?,
      locality: raw["locality"] as String,
      subLocality: raw["subLocality"] as String?,
      administrativeArea: raw["administrativeArea"] as String,
      subAdministrativeArea: raw["subAdministrativeArea"] as String?,
      isoCountryCode: raw["isoCountryCode"] as String,
      country: raw["country"] as String,
      latitude: raw["latitude"] as double,
      longitude: raw["longitude"] as double,
      percentMatch: raw["percentMatch"] as double,
    );
  }

  JobMedia parseMedia(Map<String, Object?> raw) {
    return JobMedia(
      id: raw["id"] as int,
      mediaKey: raw["mediaKey"] as String,
      caption: raw["caption"],
      position: raw["position"] as int,
    );
  }

  JobHighlight parseJobHighlight(Map<String, Object?> raw) {
    return JobHighlight(
      id: raw["id"] as int,
      caption: raw["caption"] as String,
      media: parseMany(
        raw["media"] as List<dynamic>,
        (e) => parseMedia(e as Map<String, Object?>),
      ),
      position: raw["position"] as int,
      startDate: raw["startDate"] as String?,
      active: raw["active"] as bool,
      created: raw["created"] as String,
      title: raw["title"] as String?,
      notActive: raw["notActive"] as bool,
    );
  }

  Reaction parseReaction(Map<String, Object?> raw) {
    return Reaction(
      id: raw["id"] as int,
      type: raw["type"] as String,
      userId: raw["userId"] as int,
      mongoObjectId: raw["mongoObjectId"],
    );
  }

  @override
  ManagedIdentifiedEntity<Job> operator [](Identified id) {
    // TODO: implement []
    throw UnimplementedError();
  }

  @override
  Future<Job> fetch(Identified id) {
    // TODO: implement fetch
    throw UnimplementedError();
  }

  @override
  Job parse(Map<String, Object?> raw) {
    return Job(
      id: Identified(raw["id"] as int),
      manager: this,
      title: raw["title"] as String,
      family: tryParse(raw["family"] as Map<String, Object?>?, parseFamily),
      category: tryParse(
        raw["category"] as Map<String, Object?>?,
        parseJobCategory,
      ),
      categories: parseMany(
        raw["categories"] as List<dynamic>,
        (e) => parseJobCategory(e as Map<String, Object?>),
      ),
      type: raw["type"] as String,
      locations: parseMany(
        raw["locations"] as List<dynamic>,
        (e) => parseLocation(e as Map<String, Object?>),
      ),
      link: raw["link"] as String?,
      attachmentKey: raw["attachmentKey"] as String?,
      ownerId: raw["ownerId"] as int,
      owner: raw["owner"],
      company: client.companies.parse(
        raw["companyPage"] as Map<String, Object?>,
      ),
      startDate:
          (raw["startDate"] != null)
              ? DateTime.parse(raw["startDate"] as String)
              : null,
      summary: raw["summary"] as String,
      created: DateTime.parse(raw["created"] as String),
      recommendedForSignedInUser: raw["recommendedForSignedInUser"],
      signedInUserWasInvited: raw["signedInUserWasInvited"],
      closeReason: raw["closeReason"],
      signedInUserIsInterested: raw["signedInUserIsInterested"] as bool,
    );
  }

  Future<List<Job>> fetchJobListings({int? page, int? limit}) async {
    final route =
        HttpRoute()
          ..public()
          ..jobBoard();
    final request = BasicRequest(
      route,
      1,
      queryParameters: {
        if (page != null) "page": page.toString(),
        if (limit != null) "limit": limit.toString(),
      },
    );

    final response = await client.httpHandler.executeSafe(request);
    final jobs = parseMany(
      (response.jsonBody as Map<String, dynamic>)["data"],
      (e) => parse(e as Map<String, Object?>),
    );
    return jobs;
  }
}
