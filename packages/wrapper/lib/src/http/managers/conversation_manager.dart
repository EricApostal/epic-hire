import 'package:wrapper/src/http/managers/manager.dart';
import 'package:wrapper/src/http/request.dart';
import 'package:wrapper/src/http/route.dart';
import 'package:wrapper/src/models/conversation/conversation.dart';
import 'package:wrapper/src/models/conversation/member.dart';
import 'package:wrapper/src/models/conversation/message.dart';
import 'package:wrapper/src/models/conversation/tapback.dart';
import 'package:wrapper/src/models/identified.dart';
import 'package:wrapper/src/models/identified_entity/identified_entity.dart';
import 'package:wrapper/src/utils/cache_helpers.dart';
import 'package:wrapper/src/utils/parsing_helpers.dart';

/// A manager for [Conversation]s.
class ConversationManager extends ReadOnlyManager<Conversation> {
  /// Create a new [ConversationManager].
  ConversationManager(super.config, super.client)
    : super(identifier: 'companies');

  @override
  ManagedIdentifiedEntity<Conversation> operator [](Identified id) {
    // TODO: implement []
    throw UnimplementedError();
  }

  @override
  Future<Conversation> fetch(Identified id) {
    // TODO: implement fetch
    throw UnimplementedError();
  }

  @override
  Conversation parse(Map<String, Object?> raw) {
    return Conversation(
      manager: this,
      id: Identified.parse(raw["id"] as int),
      created: DateTime.parse(raw["created"] as String),
      unreadMessages: raw["unreadMessages"] as int,
      mediaKeys: (raw["mediaKeys"] as List<dynamic>)
          .map((key) => key as String)
          .toList(),
      pinned: raw["pinned"] as bool,
      members: parseMany(
        raw["members"] as List<dynamic>,
        parseConversationMember,
      ),
      latestMessage: parseMessage(raw["latestMessage"] as Map<String, Object?>),
      name: raw["name"] as String?,
      coverImageKey: raw["coverImageKey"] as String?,
    );
  }

  Message parseMessage(Map<String, Object?> raw) {
    return Message(
      id: raw["id"] as int,
      created: DateTime.parse(raw["created"] as String),
      sender: parseConversationMember(raw["sender"] as Map<String, Object?>),
      messageType: MessageType.parse(raw["type"] as String),
      edited: raw["edited"] as bool,
      mediaKeys: (raw["mediaKeys"] as List<dynamic>)
          .map((key) => key as String)
          .toList(),
      tapbacks: parseMany(raw["tapbacks"] as List<dynamic>, parseTapback),
      pinned: raw["pinned"] as bool,
      readBy: parseMany(
        raw["readBy"] as List<dynamic>,
        parseConversationMember,
      ),
      content: raw["content"] as String?,
      threadId: raw["threadId"] as String?,
    );
  }

  Tapback parseTapback(Map<String, Object?> raw) {
    return Tapback(
      id: raw["id"] as int,
      created: DateTime.parse(raw["created"] as String),
      updated: DateTime.parse(raw["updated"] as String),
      content: raw["content"] as String,
      sender: parseConversationMember(raw),
    );
  }

  ConversationMember parseConversationMember(Map<String, Object?> raw) {
    return ConversationMember(
      id: raw["id"] as int,
      memberType: ConversationMemberType.parse(raw["type"] as String),
      relatedEntityId: raw["relatedEntityId"] as int,
      displayName: raw["displayName"] as String,
      imageKey: raw["imageKey"] as String,
      role: ConversationMemberRole.parse(raw["role"] as String),
    );
  }

  Future<List<Conversation>> fetchConversationPages() async {
    final route = HttpRoute()..conversations();
    final request = BasicRequest(
      route,
      1,
      queryParameters: {"page": "0", "limit": "4"},
    );

    final response = await client.httpHandler.executeSafe(request);
    final companies = parseMany(response.jsonBody["data"] as List<dynamic>, (
      e,
    ) {
      return parse(e as Map<String, Object?>);
    });

    companies.forEach(client.updateCacheWith);
    return companies;
  }
}
