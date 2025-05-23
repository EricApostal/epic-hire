import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wrapper/wrapper.dart';

class MessageBox extends ConsumerStatefulWidget {
  final Message message;
  const MessageBox(this.message, {super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _MessageBoxState();
}

class _MessageBoxState extends ConsumerState<MessageBox> {
  @override
  Widget build(BuildContext context) {
    return Container(child: Text(widget.message.content!));
  }
}
