import 'package:epic_hire/features/messaging/views/direct_messages.dart';
import 'package:epic_hire/features/messaging/views/message_list.dart';
import 'package:epic_hire/shared/utils/platform.dart';
import 'package:epic_hire/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MessageOverviewScreen extends ConsumerStatefulWidget {
  final int? conversationId;
  const MessageOverviewScreen({super.key, this.conversationId});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _MessageOverviewScreenState();
}

class _MessageOverviewScreenState extends ConsumerState<MessageOverviewScreen> {
  @override
  Widget build(BuildContext context) {
    if (shouldUseMobileLayout(context)) return DirectMessagesScreen();

    return Row(
      children: [
        MediaQuery.removePadding(
          context: context,
          removeLeft: true,
          removeRight: true,
          child: SizedBox(width: 300, child: DirectMessagesScreen()),
        ),

        if (widget.conversationId != null)
          Expanded(
            child: Row(
              children: [
                Container(
                  width: 2,
                  color: EpicHireTheme.of(context).foreground,
                ),
                Expanded(
                  child: MessageListScreen(
                    conversationId: widget.conversationId!,
                  ),
                ),
              ],
            ),
          ),
      ],
    );
  }
}
