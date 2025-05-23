import 'package:wrapper/src/http/managers/message_manager.dart';
import 'package:wrapper/src/models/conversation/member.dart';
import 'package:wrapper/src/models/conversation/tapback.dart';
import 'package:wrapper/src/models/identified_entity/identified_entity.dart';

class PartialMessage extends WritableIdentifiedEntity<Message> {
  @override
  final MessageManager manager;

  PartialMessage({required super.id, required this.manager});
}

class Message extends PartialMessage {
  final DateTime created;
  final ConversationMember sender;
  final MessageType messageType;
  final String? content;
  final bool edited;
  final List<String> mediaKeys;
  final List<Tapback> tapbacks;
  final bool pinned;
  // it may seem obvious to use the uuid package, but that's really only for usage / parsing
  final String? threadId;
  final List<ConversationMember> readBy;

  Message({
    required super.id,
    required super.manager,
    required this.created,
    required this.sender,
    required this.messageType,
    required this.edited,
    required this.mediaKeys,
    required this.tapbacks,
    required this.pinned,
    required this.readBy,
    this.content,
    this.threadId,
  });
}

enum MessageType {
  text._('TEXT'),
  link._('LINK'),
  media._('MEDIA');

  final String value;
  const MessageType._(this.value);

  factory MessageType.parse(String value) => MessageType.values.firstWhere(
    (messageType) => messageType.value == value,
    orElse: () => throw FormatException('Unknown message type', value),
  );
  @override
  String toString() => 'ConversationMessageType($value)';
}
