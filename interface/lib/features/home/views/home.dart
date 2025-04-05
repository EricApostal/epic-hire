import 'package:epic_hire/features/clubs/views/clubs.dart';
import 'package:epic_hire/features/home/repositories/home_feed.dart';
import 'package:epic_hire/features/home/views/home_feed.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wrapper/wrapper.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => HomeScreenState();
}

class HomeScreenState extends ConsumerState<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final homeFeed = ref.watch(homeFeedProvider);
    homeFeed.when(
      data: (data) {},
      error: (e, st) {
        print("shit fucked uo, errr");
        print(e);
        print(st);
      },
      loading: () {},
    );

    if (homeFeed.valueOrNull != null) {
      return HomeFeedScreen();
    }

    return ClubsScreen();
  }
}
