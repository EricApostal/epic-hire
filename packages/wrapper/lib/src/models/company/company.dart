import 'package:wrapper/src/http/managers/company_manager.dart';
import 'package:wrapper/src/models/identified_entity/identified_entity.dart';
import 'package:wrapper/src/models/job/category.dart';
import 'package:wrapper/src/models/job/highlight.dart';
import 'package:wrapper/src/models/job/location.dart';
import 'package:wrapper/src/models/school/school.dart';
import 'package:wrapper/src/models/story/story.dart';

class PartialCompany extends ManagedIdentifiedEntity<Company> {
  @override
  final CompanyManager manager;

  PartialCompany({required super.id, required this.manager});
}

class Company extends PartialCompany {
  final String name;
  final List<String> permissions;
  final String website;

  final List<School> schools;
  final bool nationalVisibility;
  final List<JobHighlight> highlights;
  final bool published;
  final int weight;
  final int followers;
  final List<Story> stories;
  final List<JobCategory> jobCategories;
  final List<Location> locations;
  final List<dynamic> more;
  final int hires;
  final dynamic industry;
  final List<dynamic> userBadges;
  final bool signedInUserIsAdmin;
  final String? imageKey;

  Company({
    required super.id,
    required super.manager,
    required this.name,
    required this.permissions,
    required this.website,
    this.imageKey,
    required this.schools,
    required this.nationalVisibility,
    required this.highlights,
    required this.published,
    required this.weight,
    required this.followers,
    required this.stories,
    required this.jobCategories,
    required this.locations,
    required this.more,
    required this.hires,
    this.industry,
    required this.userBadges,
    required this.signedInUserIsAdmin,
  });
}
