import 'package:epic_hire/features/authentication/repositories/login.dart';
import 'package:epic_hire/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:wrapper/wrapper.dart';

class TitleBar extends ConsumerWidget {
  final String titleName;
  final List<Widget>? extraItems;
  const TitleBar(this.titleName, {super.key, this.extraItems});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final viewPadding = MediaQuery.of(context).padding;
    final client = ref.watch(authenticationProvider).valueOrNull;
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Theme.of(context).custom.colorTheme.foreground,
      ),
      child: Padding(
        padding: EdgeInsets.fromLTRB(24, viewPadding.top + 12, 24, 12),
        child: Row(
          children: [
            Text(
              titleName,
              style: Theme.of(context).custom.textTheme.titleMedium,
            ),
            Spacer(),
            ...extraItems ?? [],
            UserAvatar(user: client?.user as User?),
          ],
        ),
      ),
    );
  }
}

class UserAvatar extends ConsumerStatefulWidget {
  final User? user;
  const UserAvatar({super.key, this.user});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => UserAvatarState();
}

class UserAvatarState extends ConsumerState<UserAvatar> {
  @override
  Widget build(BuildContext context) {
    final client = ref.watch(authenticationProvider).valueOrNull;
    return InkWell(
      onTap: () {
        HapticFeedback.mediumImpact();
        if (client?.user == null) {
          // logged in as guest
          GoRouter.of(context).go('/login');
        } else {
          GoRouter.of(context).go('/profile/${widget.user!.id}');
        }
      },

      child: ClipOval(
        child: SizedBox(
          width: 36,
          height: 36,
          child:
              (widget.user?.imageKey != null)
                  ? Image.network(
                    "https://epic-hire.s3.amazonaws.com/${widget.user!.imageKey}?size=64",
                  )
                  : Icon(
                    Icons.account_circle,
                    size: 36,
                    color: Theme.of(context).custom.colorTheme.dirtywhite,
                  ),
        ),
      ),
    );
  }
}
