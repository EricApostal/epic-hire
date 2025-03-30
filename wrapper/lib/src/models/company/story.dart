import 'package:wrapper/src/models/identified_entity/identified_entity.dart';

class PartialStory extends IdentifiedEntity<Story> {
  PartialStory({required super.id});

  @override
  Future<Story> fetch() {
    // TODO: implement fetch
    throw UnimplementedError();
  }

  @override
  Future<Story> get() {
    // TODO: implement get
    throw UnimplementedError();
  }
}

class Story extends PartialStory {
  final DateTime created;
  final String imageKey;
  final String caption;
  final List<dynamic> reactions;
  final bool commentsDisabled;
  final DateTime modified;
  final bool isHighlighted;
  final int position;
  Story({
    required super.id,
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
