import 'package:epic_hire/features/home/views/navigation_frame.dart';
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
    return ListView.builder(itemBuilder: (context, index) {});
  }
}
