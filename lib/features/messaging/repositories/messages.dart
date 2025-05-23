import 'package:epic_hire/features/authentication/repositories/login.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:wrapper/wrapper.dart';

part 'messages.g.dart';

@Riverpod(keepAlive: true)
class Messages extends _$Messages {
  WrapperRest? client;

  @override
  Future<List<Message>?> build(Identified conversationId) async {
    final auth = ref.watch(authenticationProvider).valueOrNull;
    if (auth == null) return null;

    client = auth;

    final List<Message> messages = await (await client!.conversations.get(
      conversationId,
    )).messages.fetchMany();

    return messages;
  }
}
