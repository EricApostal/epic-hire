import 'package:wrapper/src/models/conversation/member.dart';

/// A reaction on a [ConversationMessage]
class Tapback {
  final int id;
  final DateTime created;
  final DateTime updated;
  final String content;
  final ConversationMember sender;

  const Tapback({
    required this.id,
    required this.created,
    required this.updated,
    required this.content,
    required this.sender,
  });
}
