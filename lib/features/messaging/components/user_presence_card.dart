import 'package:epic_hire/shared/utils/network_key.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wrapper/wrapper.dart';

class UserPresenceIcon extends ConsumerStatefulWidget {
  final Conversation conversation;
  const UserPresenceIcon({super.key, required this.conversation});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _UserPresenceIconState();
}

class _UserPresenceIconState extends ConsumerState<UserPresenceIcon> {
  @override
  Widget build(BuildContext context) {
    return ClipOval(
      child: Image.network(
        getUrlFromImageKey(
          widget.conversation.members.first.imageKey,
          width: 256,
        ),
      ),
    );
  }
}
