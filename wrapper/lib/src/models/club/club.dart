import 'package:wrapper/src/http/managers/club_manager.dart';
import 'package:wrapper/src/models/school/school.dart';
import 'package:wrapper/src/models/identified_entity/identified_entity.dart';

class PartialClub extends ManagedIdentifiedEntity<Club> {
  @override
  final ClubManager manager;

  PartialClub({required super.id, required this.manager});
}

class Club extends PartialClub {
  final String name;
  final String? description;
  final bool published;
  final bool featured;
  final bool hasNewUi;
  final DateTime created;
  final List<dynamic> tags;
  final bool isNational;
  final List<String> memberProfilePictureKeys;
  final List<School> schools;
  final String? logoKey;

  Club({
    required super.id,
    required super.manager,
    required this.name,
    required this.description,
    required this.published,
    required this.featured,
    required this.hasNewUi,
    required this.created,
    required this.tags,
    required this.isNational,
    required this.memberProfilePictureKeys,
    required this.schools,
    this.logoKey,
  });
}
