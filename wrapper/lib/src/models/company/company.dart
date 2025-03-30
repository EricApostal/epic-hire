import 'package:wrapper/src/http/managers/company_manager.dart';
import 'package:wrapper/src/models/company/story.dart';
import 'package:wrapper/src/models/identified_entity/identified_entity.dart';

class PartialCompany extends ManagedIdentifiedEntity<Company> {
  @override
  final CompanyManager manager;

  PartialCompany({required super.id, required this.manager});
}

class Company extends PartialCompany {
  final String name;
  final List<dynamic> permissions;
  final bool published;
  final int weight;
  final int hires;
  final int followers;
  final List<dynamic> jobCategories;
  final List<Story> stories;
  final String? imageKey;

  Company({
    required super.id,
    required super.manager,
    required this.name,
    required this.permissions,
    required this.published,
    required this.weight,
    required this.hires,
    required this.followers,
    required this.jobCategories,
    required this.stories,
    this.imageKey,
  });
}
