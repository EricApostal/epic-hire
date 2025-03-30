import 'package:epic_hire/features/company/repositories/companies.dart';
import 'package:epic_hire/features/home/components/company_story_card.dart';
import 'package:epic_hire/features/story/components/story_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final companies = ref.watch(companiesProvider).valueOrNull;

    ref
        .watch(companiesProvider)
        .when(
          data: (d) {
            print("got data!");
            print(d);
          },
          error: (e, st) {
            print("ERRORED!");
            print(e);
          },
          loading: () {},
        );

    if (companies == null) {
      return Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    final padding = MediaQuery.of(context).padding;

    return Scaffold(
      body: ListView.builder(
        cacheExtent: 1000,
        padding: EdgeInsets.only(top: padding.top + 12),
        itemBuilder: (context, index) {
          final company = companies[index];
          final story = company.stories.firstOrNull;
          if (story == null) return SizedBox();
          return Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: CompanyStoryCard(company),
          );
        },
      ),
    );
  }
}
