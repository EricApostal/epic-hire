import 'package:epic_hire/features/home/repositories/home_feed.dart';
import 'package:epic_hire/features/story/components/story_card.dart';
import 'package:epic_hire/shared/components/title_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HomeFeedScreen extends ConsumerStatefulWidget {
  const HomeFeedScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomeFeedScreenState();
}

class _HomeFeedScreenState extends ConsumerState<HomeFeedScreen> {
  final GlobalKey _titleBarKey = GlobalKey();
  double _titleBarHeight = 0;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_titleBarKey.currentContext != null) {
        final RenderBox titleBarBox =
            _titleBarKey.currentContext!.findRenderObject()! as RenderBox;
        setState(() {
          _titleBarHeight = titleBarBox.size.height;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final stories = ref.watch(homeFeedProvider).valueOrNull;

    if (stories == null) return const CircularProgressIndicator();
    return Stack(
      children: [
        ListView.builder(
          padding: EdgeInsets.only(top: _titleBarHeight),
          cacheExtent: 10000,
          itemCount: stories.length,
          itemBuilder: (context, index) {
            return StoryCard(stories[index]);
          },
        ),
        Positioned(
          top: 0,
          left: 0,
          right: 0,
          child: TitleBar(
            key: _titleBarKey,
            SvgPicture.asset("assets/icons/epic-hire-banner.svg", height: 28),
          ),
        ),
      ],
    );
  }
}
