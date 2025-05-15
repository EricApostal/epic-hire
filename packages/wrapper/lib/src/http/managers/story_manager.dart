import 'package:wrapper/src/http/managers/manager.dart';
import 'package:wrapper/src/models/identified.dart';
import 'package:wrapper/src/models/identified_entity/identified_entity.dart';
import 'package:wrapper/src/models/story/story.dart';
import 'package:wrapper/src/utils/parsing_helpers.dart';

class StoryManager extends ReadOnlyManager<Story> {
  /// Create a new [CompanyManager].
  StoryManager(super.config, super.client) : super(identifier: 'stories');

  @override
  ManagedIdentifiedEntity<Story> operator [](Identified id) {
    // TODO: implement []
    throw UnimplementedError();
  }

  @override
  Future<Story> fetch(Identified id) {
    // TODO: implement fetch
    throw UnimplementedError();
  }

  @override
  Story parse(Map<String, Object?> raw) {
    return Story(
      manager: this,
      id: Identified(raw["id"] as int),
      created: DateTime.parse(raw["created"] as String),
      imageKey: raw["imageKey"] as String,
      reactions: raw["reactions"] as List<dynamic>,
      caption: raw["caption"] as String,
      commentsDisabled: raw["captionsDisabled"] as bool? ?? false,
      modified: DateTime.parse(raw["modified"] as String),
      isHighlighted: raw["isHighlighted"] as bool? ?? false,
      position: raw["position"] as int,
      poster: tryParse(
        raw["poster"] as Map<String, Object?>?,
        parseStoryPoster,
      ),
    );
  }

  StoryPoster parseStoryPoster(Map<String, Object?> raw) {
    return StoryPoster(
      id: Identified.parse(raw["id"] as int),
      name: raw["name"] as String,
      type: raw["type"] as String,
      descriptor: raw["descriptor"] as String?,
      imageKey: raw["imageKey"] as String?,
    );
  }
}
