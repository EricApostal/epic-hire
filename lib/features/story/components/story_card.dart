import 'package:cached_network_image/cached_network_image.dart';
import 'package:epic_hire/shared/components/image/fade_in.dart';
import 'package:epic_hire/shared/utils/network_key.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wrapper/wrapper.dart';

class StoryCard extends ConsumerStatefulWidget {
  final Story story;
  const StoryCard(this.story, {super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _StoryCardState();
}

class _StoryCardState extends ConsumerState<StoryCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                if (widget.story.poster!.imageKey != null)
                  SizedBox(
                    width: 40,
                    child: ClipOval(
                      child: CustomFadeInWidget(
                        image: Image.network(
                          width: 40,
                          height: 40,
                          getUrlFromImageKey(
                            widget.story.poster!.imageKey!,
                            width: 128,
                          ),
                        ),
                      ),
                    ),
                  ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.story.poster!.name,
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                      if (widget.story.poster!.descriptor != null)
                        Text(
                          widget.story.poster!.descriptor!.replaceAll(
                            "\n",
                            " | ",
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          SizedBox(
            width: double.infinity,
            child: CachedNetworkImage(
              imageUrl: getUrlFromImageKey(widget.story.imageKey),
            ),
          ),

          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              widget.story.caption,
              maxLines: 2,
              overflow: TextOverflow.fade,
            ),
          ),
        ],
      ),
    );
  }
}
