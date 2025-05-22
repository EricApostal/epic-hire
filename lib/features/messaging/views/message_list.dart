import 'package:epic_hire/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MessageListScreen extends ConsumerStatefulWidget {
  final int conversationId;
  const MessageListScreen({super.key, required this.conversationId});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _MessageListScreenState();
}

class _MessageListScreenState extends ConsumerState<MessageListScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: EpicHireTheme.of(context).background,
      body: Center(child: Text(widget.conversationId.toString())),
    );
  }
}
