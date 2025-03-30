import 'package:wrapper/src/http/managers/manager.dart';
import 'package:wrapper/src/models/identified.dart';
import 'package:wrapper/src/models/identified_entity/identified_entity.dart';
import 'package:wrapper/src/models/job/category.dart';
import 'package:wrapper/src/models/job/family.dart';
import 'package:wrapper/src/models/job/highlight.dart';
import 'package:wrapper/src/models/job/job.dart';
import 'package:wrapper/src/models/job/location.dart';
import 'package:wrapper/src/models/job/media.dart';
import 'package:wrapper/src/models/job/reaction.dart';
import 'package:wrapper/src/models/job/story.dart';
import 'package:wrapper/src/utils/parsing_helpers.dart'; // Assuming this is where parseMany is defined

class JobManager extends ReadOnlyManager<Job> {
  /// Create a new [CompanyManager].
  JobManager(super.config, super.client) : super(identifier: 'schools');

  // Parsing functions for related models
  Family parseFamily(Map<String, Object?> raw) {
    return Family(id: raw["id"] as int, name: raw["name"] as String);
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

  Media parseMedia(Map<String, Object?> raw) {
    return Media(
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

  Story parseStory(Map<String, Object?> raw) {
    return Story(
      id: raw["id"] as int,
      created: raw["created"] as String,
      imageKey: raw["imageKey"] as String,
      caption: raw["caption"] as String,
      reactions: parseMany(
        raw["reactions"] as List<dynamic>,
        (e) => parseReaction(e as Map<String, Object?>),
      ),
      commentsDisabled: raw["commentsDisabled"] as bool,
      modified: raw["modified"] as String,
      isHighlighted: raw["isHighlighted"] as bool,
      position: raw["position"] as int,
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
      family: parseFamily(raw["family"] as Map<String, Object?>),
      category: parseJobCategory(raw["category"] as Map<String, Object?>),
      categories: parseMany(
        raw["categories"] as List<dynamic>,
        (e) => parseJobCategory(e as Map<String, Object?>),
      ),
      type: raw["type"] as String,
      locations: parseMany(
        raw["locations"] as List<dynamic>,
        (e) => parseLocation(e as Map<String, Object?>),
      ),
      link: raw["link"] as String,
      attachmentKey: raw["attachmentKey"] as String?,
      ownerId: raw["ownerId"] as int,
      owner: raw["owner"],
      company: client.companies.parse(
        raw["companyPage"] as Map<String, Object?>,
      ),
      startDate: raw["startDate"] as String,
      summary: raw["summary"] as String,
      created: raw["created"] as String,
      recommendedForSignedInUser: raw["recommendedForSignedInUser"],
      signedInUserWasInvited: raw["signedInUserWasInvited"],
      closeReason: raw["closeReason"],
      signedInUserIsInterested: raw["signedInUserIsInterested"] as bool,
    );
  }
}
