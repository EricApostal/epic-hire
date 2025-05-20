import 'package:wrapper/src/client.dart';
import 'package:wrapper/src/models/company/company.dart';
import 'package:wrapper/src/models/conversation/conversation.dart';
import 'package:wrapper/src/models/user/user.dart';

extension CacheUpdates on WrapperRest {
  /// Update the caches for this client using [entity] by registering (or removing, if [entity] is a delete event) any cacheable entities reachable from [entity].
  void updateCacheWith(Object? entity) => switch (entity) {
    // "Root" types - with their own cache
    // Events
    User() => entity.manager.cache[entity.id] = entity,
    Company() => entity.manager.cache[entity.id] = entity,
    Conversation() => entity.manager.cache[entity.id] = entity,
    null => null,
    _ => () {
      assert(() {
        logger
          ..warning(
            'Tried to update cache for ${entity.runtimeType}, but that type was not handled.',
          )
          ..info(
            'This is a bug! Your client will still work regardless, so you can also ignore this message.',
          );
        return true;
      }());
    }(),
  };
}
