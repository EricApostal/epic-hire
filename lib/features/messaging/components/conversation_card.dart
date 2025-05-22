import 'package:cached_network_image/cached_network_image.dart';
import 'package:epic_hire/features/authentication/repositories/login.dart';
import 'package:epic_hire/shared/utils/network_key.dart';
import 'package:epic_hire/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wrapper/wrapper.dart';

class ConversationCard extends ConsumerStatefulWidget {
  final Conversation conversation;
  const ConversationCard({super.key, required this.conversation});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _ConversationCardState();
}

class _ConversationCardState extends ConsumerState<ConversationCard> {
  @override
  Widget build(BuildContext context) {
    String conversationName = "";
    if (widget.conversation.name == null) {
      for (var member in widget.conversation.members) {
        conversationName += "${member.displayName}, ";
      }
      conversationName = conversationName.substring(
        0,
        conversationName.length - 2,
      );
    } else {
      conversationName = widget.conversation.name!;
    }

    final theme = EpicHireTheme.of(context);
    final textTheme = Theme.of(context).textTheme;
    return ClipRRect(
      borderRadius: BorderRadius.circular(12),
      child: OutlinedButton(
        style: OutlinedButton.styleFrom(
          padding: EdgeInsets.zero,
          backgroundColor: Colors.transparent,
          minimumSize: Size.zero,
          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
          side: BorderSide.none,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0)),
          // change hover / select color to white
          foregroundColor: theme.foreground,
        ),
        onPressed: () => {HapticFeedback.lightImpact()},
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: 48,
                height: 48,
                child: _ConversationIcon(widget.conversation),
              ),
              SizedBox(width: 8),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(conversationName, style: textTheme.bodyMedium!),
                    Text(
                      widget.conversation.latestMessage.content ??
                          "no message content",
                      style: textTheme.bodyMedium!.copyWith(color: theme.gray),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ConversationIcon extends ConsumerStatefulWidget {
  final Conversation conversation;
  const _ConversationIcon(this.conversation);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _ConversationIconState();
}

class _ConversationIconState extends ConsumerState<_ConversationIcon> {
  @override
  Widget build(BuildContext context) {
    final auth = ref.watch(authenticationProvider).valueOrNull;
    ConversationMember iconToUse = widget.conversation.members.firstWhere((
      member,
    ) {
      print("${member.id} - ${auth!.user!.id.value}");
      return member.relatedEntityId != auth.user!.id.value;
    });

    return ClipRRect(
      borderRadius: BorderRadius.circular(16),
      child: CachedNetworkImage(
        fit: BoxFit.cover,
        imageUrl: getUrlFromImageKey(iconToUse.imageKey, width: 128),
      ),
    );

    // return Image.network(
    //   getUrlFromImageKey(widget.conversation.coverImageKey!),
    // );
  }
}
