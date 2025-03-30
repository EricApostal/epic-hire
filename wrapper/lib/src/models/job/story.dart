import 'package:wrapper/src/models/job/reaction.dart';

class Story {
  final int id;
  final String created;
  final String imageKey;
  final String caption;
  final List<Reaction> reactions;
  final bool commentsDisabled;
  final String modified;
  final bool isHighlighted;
  final int position;

  Story({
    required this.id,
    required this.created,
    required this.imageKey,
    required this.caption,
    required this.reactions,
    required this.commentsDisabled,
    required this.modified,
    required this.isHighlighted,
    required this.position,
  });
}
