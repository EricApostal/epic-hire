import 'package:wrapper/src/http/managers/conversation_manager.dart';
import 'package:wrapper/src/http/managers/manager.dart';
import 'package:wrapper/src/models/conversation/member.dart';
import 'package:wrapper/src/models/conversation/message.dart';
import 'package:wrapper/src/models/identified_entity/identified_entity.dart';
import 'package:wrapper/src/models/user/user.dart';

class PartialConversation extends ManagedIdentifiedEntity<Conversation> {
  @override
  final ConversationManager manager;

  PartialConversation({required super.id, required this.manager});
}

class Conversation extends PartialConversation {
  final DateTime created;
  final List<ConversationMember> members;
  final Message latestMessage;
  final int unreadMessages;
  final List<String> mediaKeys;
  final bool pinned;

  final String? name;
  final String? coverImageKey;

  Conversation({
    required super.id,
    required super.manager,
    required this.created,
    required this.members,
    required this.latestMessage,
    required this.unreadMessages,
    required this.mediaKeys,
    required this.pinned,
    this.name,
    this.coverImageKey,
  });
}
