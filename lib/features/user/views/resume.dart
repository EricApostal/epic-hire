import 'package:epic_hire/features/user/repositories/resume.dart';
import 'package:epic_hire/features/user/repositories/user.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pdfrx/pdfrx.dart';

class ResumeScreen extends ConsumerStatefulWidget {
  final int userId;
  const ResumeScreen({super.key, required this.userId});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ResumeScreenState();
}

class _ResumeScreenState extends ConsumerState<ResumeScreen> {
  @override
  Widget build(BuildContext context) {
    final userResumeData = ref.watch(userResumeProvider(widget.userId));

    userResumeData.when(
      data: (data) {},
      error: (e, st) {
        print(e);
        print(st);
      },
      loading: () {},
    );

    final userResume =
        ref.watch(epicUserProvider(widget.userId)).valueOrNull!.resumeKey ??
        "oops";

    if (userResumeData.valueOrNull == null) {
      return Center(child: CircularProgressIndicator());
    }
    return PdfViewer.data(userResumeData.valueOrNull!, sourceName: userResume);
  }
}
