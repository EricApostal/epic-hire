import 'package:epic_hire/features/authentication/repositories/login.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:wrapper/wrapper.dart';

part 'conversations.g.dart';

@Riverpod(keepAlive: true)
class Conversations extends _$Conversations {
  WrapperRest? client;

  @override
  Future<List<Conversation>?> build() async {
    final _auth = ref.watch(authenticationProvider).valueOrNull;
    if (_auth == null) return null;

    client = _auth;

    return await client!.conversations.fetchConversationPages(0, 10);
  }
}
