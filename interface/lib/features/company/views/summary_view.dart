import 'package:epic_hire/features/company/repositories/companies.dart';
import 'package:epic_hire/features/home/components/company_story_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CompanySummaryListScreen extends ConsumerStatefulWidget {
  const CompanySummaryListScreen({super.key});

  @override
  ConsumerState<CompanySummaryListScreen> createState() =>
      _CompanySummaryListScreenState();
}

class _CompanySummaryListScreenState
    extends ConsumerState<CompanySummaryListScreen> {
  @override
  Widget build(BuildContext context) {
    final companies = ref.watch(companiesProvider).valueOrNull;
    ref
        .watch(companiesProvider)
        .when(
          data: (data) {
            return data;
          },
          loading: () {
            print("loading...");
            return null;
          },
          error: (error, stack) {
            print("error! $error");
            print(stack);

            return null;
          },
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
