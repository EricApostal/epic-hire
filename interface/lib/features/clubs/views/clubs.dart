import 'package:epic_hire/features/clubs/components/club_card.dart';
import 'package:epic_hire/features/clubs/repositories/clubs.dart';
import 'package:epic_hire/shared/components/title_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ClubsScreen extends ConsumerStatefulWidget {
  const ClubsScreen({super.key});

  @override
  ConsumerState<ClubsScreen> createState() => _ClubsScreenState();
}

class _ClubsScreenState extends ConsumerState<ClubsScreen> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    _scrollController.addListener(() {
      if (_scrollController.position.pixels >=
          _scrollController.position.maxScrollExtent - 500) {
        ref.read(clubsProvider.notifier).getNextPage();
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final clubs = ref.watch(clubsProvider).valueOrNull;

    ref
        .watch(clubsProvider)
        .when(
          data: (data) {
            return data;
          },
          loading: () {
            return null;
          },
          error: (error, stack) {
            print("error! $error");
            print(stack);

            return null;
          },
        );

    if (clubs == null) {
      return Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    return Scaffold(
      body: Column(
        children: [
          TitleBar("Explore Clubs"),
          Expanded(
            child: ListView.builder(
              controller: _scrollController,
              cacheExtent: 1000,
              itemCount: clubs.length,
              padding: EdgeInsets.only(top: 0),
              itemBuilder: (context, index) {
                final club = clubs[index];
                return Padding(
                  padding: const EdgeInsets.only(bottom: 0),
                  child: ClubCard(club),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
