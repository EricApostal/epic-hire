import 'package:epic_hire/features/jobs/components/job_card.dart';
import 'package:epic_hire/features/jobs/repositories/jobs.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class JobsList extends ConsumerStatefulWidget {
  const JobsList({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _JobsListState();
}

class _JobsListState extends ConsumerState<JobsList> {
  @override
  Widget build(BuildContext context) {
    final jobListener = ref.watch(jobsProvider);
    jobListener.when(
      data: (jobList) => print("data"),
      loading: () => print("Loading..."),
      error: (error, stack) => print('Error: $error, Stack: $stack'),
    );

    final jobs = jobListener.valueOrNull;
    if (jobs == null) {
      return Center(child: CircularProgressIndicator());
    }

    return ListView.builder(
      padding: const EdgeInsets.only(top: 0),
      itemCount: jobs.length,
      itemBuilder: (context, index) {
        final job = jobs[index];
        return Column(
          // TODO: isFirstCard is old code from a old design I had.
          // This logic should be moved back to the listview, unless
          // we create a new design that requires it.
          children: [
            JobCard(job, isFirstCard: index == 0),
            Divider(),
          ],
        );
      },
    );
  }
}
