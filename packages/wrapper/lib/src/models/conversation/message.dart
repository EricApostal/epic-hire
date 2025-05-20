import 'package:wrapper/src/models/conversation/member.dart';
import 'package:wrapper/src/models/conversation/tapback.dart';

class Message {
  final int id;
  final DateTime created;
  final ConversationMember sender;
  final MessageType messageType;
  final String? content;
  final bool edited;
  final List<String> mediaKeys;
  final List<Tapback> tapbacks;
  final bool pinned;
  final String?
  threadId; // it may seem obvious to use the uuid package, but that's really only for usage / parsing
  final List<ConversationMember> readBy;

  const Message({
    required this.id,
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
    orElse: () => throw FormatException('Unknown member type', value),
  );
  @override
  String toString() => 'ConversationMemberType($value)';
}
