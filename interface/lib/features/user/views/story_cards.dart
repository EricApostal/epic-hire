import 'package:epic_hire/features/user/repositories/user.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:wrapper/wrapper.dart';

class StoryCardPage extends ConsumerStatefulWidget {
  final int userId;

  const StoryCardPage({super.key, required this.userId});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _StoryCardPageState();
}

class _StoryCardPageState extends ConsumerState<StoryCardPage> {
  @override
  Widget build(BuildContext context) {
    final user = ref.watch(epicUserProvider(widget.userId)).valueOrNull;

    if (user == null) {
      return const Center(child: CircularProgressIndicator());
    }

    final stories = user.stories;

    return Padding(
      padding: const EdgeInsets.all(0),
      child: GridView.builder(
        padding: EdgeInsets.all(8.0),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          crossAxisSpacing: 8.0,
          mainAxisSpacing: 8.0,
          childAspectRatio: 0.8,
        ),
        itemCount: stories.length,
        itemBuilder: (context, index) {
          final story = stories[index];
          return StoryGridItem(userId: widget.userId, story: story, idx: index);
        },
      ),
    );
  }
}

class StoryGridItem extends StatelessWidget {
  final Story story;
  final int userId;
  final int idx;

  const StoryGridItem({
    super.key,
    required this.story,
    required this.userId,
    required this.idx,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        GoRouter.of(context).push(
          "/profile/$userId/stories",
          extra: {'startingIndex': idx.toString()},
        );
      },
      child: Stack(
        fit: StackFit.expand,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8.0),
            child: Image.network(
              "https://epic-hire.s3.amazonaws.com/${story.imageKey}",
              fit: BoxFit.cover,
              loadingBuilder: (context, child, loadingProgress) {
                if (loadingProgress == null) return child;
                return const Center(child: CircularProgressIndicator());
              },
              errorBuilder:
                  (context, error, stackTrace) =>
                      const Center(child: Icon(Icons.error)),
            ),
          ),

          if (story.isHighlighted)
            Positioned(
              top: 4,
              right: 4,
              child: Container(
                padding: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Icon(Icons.star, color: Colors.white, size: 12),
              ),
            ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 8),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                  colors: [Colors.black.withOpacity(0.7), Colors.transparent],
                ),
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(8),
                  bottomRight: Radius.circular(8),
                ),
              ),
              child: Text(
                story.caption,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(color: Colors.white, fontSize: 12),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
