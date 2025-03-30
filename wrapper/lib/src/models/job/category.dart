import 'package:wrapper/src/models/job/family.dart';

class JobCategory {
  final int id;
  final String name;
  final String imageKey;
  final JobFamily family;
  final List<String> playbookTags;
  final String? mongoObjectId;

  JobCategory({
    required this.id,
    required this.name,
    required this.imageKey,
    required this.family,
    required this.playbookTags,
    this.mongoObjectId,
  });
}
