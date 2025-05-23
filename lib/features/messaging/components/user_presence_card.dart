import 'package:cached_network_image/cached_network_image.dart';
import 'package:epic_hire/features/authentication/repositories/login.dart';
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
    final auth = ref.watch(authenticationProvider).valueOrNull;
    ConversationMember member = widget.conversation.members.firstWhere((
      member,
    ) {
      return member.relatedEntityId != auth!.user!.id.value;
    });

    return AspectRatio(
      aspectRatio: 1,
      child: ClipOval(
        child: CachedNetworkImage(
          fit: BoxFit.cover,
          imageUrl: getUrlFromImageKey(member.imageKey, width: 256),
        ),
      ),
    );
  }
}
