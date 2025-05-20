import 'package:epic_hire/features/messaging/components/user_presence_card.dart';
import 'package:epic_hire/features/messaging/repositories/conversations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DirectMessagesScreen extends ConsumerStatefulWidget {
  const DirectMessagesScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _DirectMessagesScreenState();
}

class _DirectMessagesScreenState extends ConsumerState<DirectMessagesScreen> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: (context, index) {
        if (index == 0) {
          return SizedBox(height: 100, child: _HorizontalRecents());
        }
        return Card(child: Text("Temporary Card"));
      },
    );
  }
}

class _HorizontalRecents extends ConsumerStatefulWidget {
  const _HorizontalRecents();

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      __HorizontalRecentsState();
}

class __HorizontalRecentsState extends ConsumerState<_HorizontalRecents> {
  @override
  Widget build(BuildContext context) {
    final padding = MediaQuery.paddingOf(context);

    final conversations = ref.watch(conversationsProvider).valueOrNull;
    if (conversations == null) {
      return Center(child: CircularProgressIndicator());
    }

    return ListView.builder(
      padding: EdgeInsets.only(
        top: padding.top + 8,
        left: padding.left + 4,
        right: padding.right + 4,
      ),
      scrollDirection: Axis.horizontal,
      itemCount: conversations.length,
      itemBuilder: (context, index) {
        return SizedBox(
          // width: 72,
          // height: 72,
          child: UserPresenceIcon(conversation: conversations[index]),
        );
      },
    );
  }
}
