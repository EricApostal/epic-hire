import 'package:epic_hire/features/user/repositories/user.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:story/story.dart';

class StorySliderScreen extends ConsumerStatefulWidget {
  final int userId;
  final int startingIndex;
  const StorySliderScreen({
    super.key,
    required this.userId,
    required this.startingIndex,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _StorySliderScreenState();
}

class _StorySliderScreenState extends ConsumerState<StorySliderScreen> {
  @override
  Widget build(BuildContext context) {
    final user = ref.watch(epicUserProvider(widget.userId)).valueOrNull;
    if (user == null) {
      return Center(child: CircularProgressIndicator());
    }

    return StoryPageView(
      initialStoryIndex: (pageIndex) => widget.startingIndex,
      indicatorPadding: EdgeInsets.only(
        top: MediaQuery.of(context).viewPadding.top + 4,
      ),
      onPageLimitReached: () {
        Navigator.of(context).pop();
      },
      itemBuilder: (context, pageIndex, storyIndex) {
        return Image.network(
          "https://epic-hire.s3.amazonaws.com/${user.stories[storyIndex].imageKey}",
          fit: BoxFit.cover,
          loadingBuilder: (context, child, loadingProgress) {
            if (loadingProgress == null) return child;
            return const Center(child: CircularProgressIndicator());
          },

          errorBuilder:
              (context, error, stackTrace) =>
                  const Center(child: Icon(Icons.error)),
        );
      },
      storyLength: (pageIndex) {
        return user.stories.length;
      },
      pageLength: 1,
    );
  }
}
