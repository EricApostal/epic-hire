import 'package:wrapper/src/builders/builder.dart';
import 'package:wrapper/src/http/managers/manager.dart';
import 'package:wrapper/src/http/request.dart';
import 'package:wrapper/src/http/route.dart';
import 'package:wrapper/src/models/conversation/message.dart';
import 'package:wrapper/src/models/conversation/tapback.dart';
import 'package:wrapper/src/models/identified.dart';
import 'package:wrapper/src/models/identified_entity/identified_entity.dart';
import 'package:wrapper/src/utils/parsing_helpers.dart';

/// A manager for [Message]s in a [Conversation].
class MessageManager extends Manager<Message> {
  final Identified conversationId;
  MessageManager(super.config, super.client, {required this.conversationId})
    : super(identifier: 'messages');

  @override
  WritableIdentifiedEntity<Message> operator [](Identified id) {
    // TODO: implement []
    throw UnimplementedError();
  }

  @override
  Future<Message> create(covariant CreateBuilder<Message> builder) {
    // TODO: implement create
    throw UnimplementedError();
  }

  @override
  Future<void> delete(Identified id) {
    // TODO: implement delete
    throw UnimplementedError();
  }

  @override
  Future<Message> fetch(Identified id) {
    // TODO: implement fetch
    throw UnimplementedError();
  }

  @override
  Future<Message> update(
    Identified id,
    covariant UpdateBuilder<Message> builder,
  ) {
    // TODO: implement update
    throw UnimplementedError();
  }

  @override
  Message parse(Map<String, Object?> raw) {
    return Message(
      id: Identified.parse(raw["id"] as int),
      manager: this,
      created: DateTime.parse(raw["created"] as String),
      sender: client.conversations.parseConversationMember(
        raw["sender"] as Map<String, Object?>,
      ),
      messageType: MessageType.parse(raw["type"] as String),
      edited: raw["edited"] as bool,
      mediaKeys: (raw["mediaKeys"] as List<dynamic>)
          .map((key) => key as String)
          .toList(),
      tapbacks: parseMany(raw["tapbacks"] as List<dynamic>, parseTapback),
      pinned: raw["pinned"] as bool,
      readBy: parseMany(
        raw["readBy"] as List<dynamic>,
        client.conversations.parseConversationMember,
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
      sender: client.conversations.parseConversationMember(
        raw["sender"] as Map<String, dynamic>,
      ),
    );
  }

  Future<List<Message>> fetchMany({int page = 0, int limit = 60}) async {
    final route = HttpRoute()
      ..conversations(id: conversationId.value.toString())
      ..messages();

    final request = BasicRequest(
      route,
      1,
      queryParameters: {"page": page.toString(), "limit": limit.toString()},
    );

    final response = await client.httpHandler.executeSafe(request);
    final parsed = parseMany(response.jsonBody["data"], parse);

    return parsed;
  }
}
