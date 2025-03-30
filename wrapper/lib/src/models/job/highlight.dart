import 'package:wrapper/src/models/job/media.dart';

class JobHighlight {
  final int id;
  final String caption;
  final List<JobMedia> media;
  final int position;
  final String? startDate;
  final bool active;
  final String created;
  final String? title;
  final bool notActive;

  JobHighlight({
    required this.id,
    required this.caption,
    required this.media,
    required this.position,
    this.startDate,
    required this.active,
    required this.created,
    this.title,
    required this.notActive,
  });
}
