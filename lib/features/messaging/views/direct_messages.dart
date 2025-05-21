import 'package:epic_hire/features/messaging/components/user_presence_card.dart';
import 'package:epic_hire/features/messaging/repositories/conversations.dart';
import 'package:epic_hire/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';

class DirectMessagesScreen extends ConsumerStatefulWidget {
  const DirectMessagesScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _DirectMessagesScreenState();
}

class _DirectMessagesScreenState extends ConsumerState<DirectMessagesScreen> {
  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverAppBar(
          floating: true,
          pinned: true,
          automaticallyImplyLeading: false,
          expandedHeight: 100,
          flexibleSpace: const FlexibleSpaceBar(background: _AppBar()),
          bottom: PreferredSize(
            preferredSize: Size.fromHeight(70),
            child: Padding(
              padding: const EdgeInsets.all(18),
              child: Row(
                children: [
                  SvgPicture.asset(
                    "assets/icons/epic-hire-banner.svg",
                    height: 30,
                  ),
                ],
              ),
            ),
          ),
        ),
        SliverList(
          delegate: SliverChildBuilderDelegate((context, index) {
            if (index == 0) {
              return SizedBox(height: 100, child: _HorizontalRecents());
            }
            return Card(child: Text("Temporary Card"));
          }),
        ),
      ],
    );
  }
}

class _AppBar extends ConsumerStatefulWidget {
  const _AppBar();

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => __AppBarState();
}

class __AppBarState extends ConsumerState<_AppBar> {
  @override
  Widget build(BuildContext context) {
    final theme = EpicHireTheme.of(context);
    return Container(
      decoration: BoxDecoration(color: theme.foreground),
      child: const Align(
        alignment: Alignment.centerLeft,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Text("Funny top bar", style: TextStyle(fontSize: 24)),
        ),
      ),
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
    final conversations = ref.watch(conversationsProvider).valueOrNull;
    if (conversations == null) {
      return const Center(child: CircularProgressIndicator());
    }

    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: conversations.length,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.only(right: 8),
          child: UserPresenceIcon(conversation: conversations[index]),
        );
      },
    );
  }
}
