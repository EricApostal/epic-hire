import 'package:wrapper/src/http/managers/story_manager.dart';
import 'package:wrapper/src/models/identified.dart';
import 'package:wrapper/src/models/identified_entity/identified_entity.dart';
import 'package:wrapper/src/utils/to_string_helper/mirrors_impl.dart';

class PartialStory extends ManagedIdentifiedEntity<Story> {
  @override
  final StoryManager manager;
  PartialStory({required super.id, required this.manager});
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
  final StoryPoster? poster;
  Story({
    required super.id,
    required super.manager,
    required this.created,
    required this.imageKey,
    required this.caption,
    required this.reactions,
    required this.commentsDisabled,
    required this.modified,
    required this.isHighlighted,
    required this.position,
    this.poster,
  });
}

class StoryPoster with ToStringHelper {
  final Identified id;
  final String name;
  final String type;
  final String? descriptor;
  final String? imageKey;

  StoryPoster({
    required this.id,
    required this.name,
    required this.type,
    this.descriptor,
    this.imageKey,
  });
}
