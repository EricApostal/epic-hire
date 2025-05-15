import 'package:wrapper/src/http/managers/job_manager.dart';
import 'package:wrapper/src/models/identified_entity/identified_entity.dart';
import 'package:wrapper/wrapper.dart';

class Job extends PartialJob {
  final String title;
  final JobFamily? family;
  final JobCategory? category;
  final List<JobCategory> categories;
  final String type;
  final List<Location> locations;
  final String? link;
  final String? attachmentKey;
  final int ownerId;
  final dynamic owner;
  final Company company;
  final DateTime? startDate;
  final String summary;
  final DateTime created;
  final dynamic recommendedForSignedInUser;
  final dynamic signedInUserWasInvited;
  final dynamic closeReason;
  final bool signedInUserIsInterested;

  Job({
    required super.id,
    required super.manager,
    required this.title,
    this.family,
    this.category,
    required this.categories,
    required this.type,
    required this.locations,
    this.link,
    this.attachmentKey,
    required this.ownerId,
    this.owner,
    required this.company,
    this.startDate,
    required this.summary,
    required this.created,
    this.recommendedForSignedInUser,
    this.signedInUserWasInvited,
    this.closeReason,
    required this.signedInUserIsInterested,
  });
}

class PartialJob extends ManagedIdentifiedEntity<Job> {
  @override
  final JobManager manager;

  PartialJob({required super.id, required this.manager});
}
