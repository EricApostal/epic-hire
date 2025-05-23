import 'package:epic_hire/features/messaging/components/app_search_bar.dart';
import 'package:epic_hire/features/messaging/components/conversation_card.dart';
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
    final conversations = ref.watch(conversationsProvider).valueOrNull;
    final theme = Theme.of(context);
    final colorTheme = EpicHireTheme.of(context);

    if (conversations == null) {
      return const Center(child: CircularProgressIndicator());
    }

    return Scaffold(
      backgroundColor: colorTheme.background,
      floatingActionButton: FloatingActionButton(
        onPressed: () => {},
        child: Icon(Icons.add_rounded, color: colorTheme.dirtyWhite),
      ),
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            floating: true,
            pinned: true,
            automaticallyImplyLeading: false,
            expandedHeight: 110,

            flexibleSpace: const FlexibleSpaceBar(background: _AppBar()),
            bottom: PreferredSize(
              preferredSize: Size.fromHeight(70),
              child: Padding(
                padding: const EdgeInsets.only(
                  left: 8,
                  right: 8,
                  top: 0,
                  bottom: 8,
                ),
                child: AppSearchBar(),
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              childCount: conversations.length + 1,
              (context, index) {
                if (index == 0) {
                  return Padding(
                    padding: const EdgeInsets.only(
                      left: 18,
                      right: 18,
                      top: 18,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 100, child: _HorizontalRecents()),
                        SizedBox(height: 8),
                        Text("Messages", style: theme.textTheme.labelLarge),
                      ],
                    ),
                  );
                }
                return Padding(
                  padding: const EdgeInsets.only(left: 8, right: 8, bottom: 2),
                  child: ConversationCard(
                    conversation: conversations[index - 1],
                  ),
                );
              },
            ),
          ),
        ],
      ),
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
    final padding = MediaQuery.paddingOf(context);
    return Container(
      decoration: BoxDecoration(color: theme.foreground),
      child: Align(
        alignment: Alignment.topLeft,
        child: Padding(
          padding: EdgeInsets.only(left: 16, right: 16, top: 10 + padding.top),
          child: SvgPicture.asset(
            "assets/icons/epic-hire-banner.svg",
            height: 30,
          ),
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
      padding: EdgeInsets.only(left: 0),
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.only(right: 8),
          child: UserPresenceIcon(conversation: conversations[index]),
        );
      },
    );
  }
}
