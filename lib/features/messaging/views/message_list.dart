import 'package:epic_hire/features/messaging/components/message_box.dart';
import 'package:epic_hire/features/messaging/repositories/messages.dart';
import 'package:epic_hire/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wrapper/wrapper.dart';

class MessageListScreen extends ConsumerStatefulWidget {
  final int conversationId;
  const MessageListScreen({super.key, required this.conversationId});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _MessageListScreenState();
}

class _MessageListScreenState extends ConsumerState<MessageListScreen> {
  @override
  void initState() {
    // ref.listenManual(
    //   messagesProvider(Identified.parse(widget.conversationId)),
    //   (a, b) {
    //     print(a);
    //   },
    // );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final messages =
        ref
            .watch(messagesProvider(Identified.parse(widget.conversationId)))
            .valueOrNull ??
        [];

    return Scaffold(
      backgroundColor: EpicHireTheme.of(context).background,
      body: ListView.builder(
        padding: EdgeInsets.only(left: 12, right: 12, top: 12, bottom: 12),
        reverse: true,
        itemCount: messages.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: MessageBox(messages[index]),
          );
        },
      ),
    );
  }
}
