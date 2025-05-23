import 'package:epic_hire/shared/components/image/fade_in.dart';
import 'package:epic_hire/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wrapper/wrapper.dart';

class CompanyStoryCard extends ConsumerStatefulWidget {
  final Company company;
  const CompanyStoryCard(this.company, {super.key});

  @override
  ConsumerState<CompanyStoryCard> createState() => _CompanyStoryCardState();
}

class _CompanyStoryCardState extends ConsumerState<CompanyStoryCard> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    String caption = widget.company.stories.first.caption;
    if (caption == "") caption = "View more";

    return Container(
      decoration: BoxDecoration(color: EpicHireTheme.of(context).background),
      child: Padding(
        padding: EdgeInsets.only(bottom: 0, top: 0),
        child: Column(
          children: [
            Row(
              children: [
                const SizedBox(width: 8),
                if (widget.company.imageKey != null)
                  ClipOval(
                    child: CustomFadeInWidget(
                      image: Image.network(
                        width: 30,
                        height: 30,
                        "https://epic-hire.s3.amazonaws.com/${widget.company.imageKey!}",
                      ),
                    ),
                  ),
                SizedBox(width: 10),
                Text(widget.company.name, style: theme.textTheme.bodyMedium),
              ],
            ),
            const SizedBox(height: 10),
            ClipRRect(
              borderRadius: BorderRadius.all(Radius.circular(0)),
              child: SizedBox(
                height: 400,
                child: CustomFadeInWidget(
                  image: Image.network(
                    "https://epic-hire.s3.amazonaws.com/${widget.company.stories.first.imageKey}",
                    height: 400,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 4),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4.0),
              child: Column(
                children: [
                  // Row(
                  //   children: [
                  //     OutlinedButton(
                  //       onPressed: () {},
                  //       style: OutlinedButton.styleFrom(
                  //         minimumSize: Size.zero,
                  //         foregroundColor:
                  //             EpicHireTheme.of(context).dirtyWhite,
                  //         padding: const EdgeInsets.only(
                  //           top: 12,
                  //           bottom: 12,
                  //           left: 8,
                  //           right: 8,
                  //         ),
                  //         side: const BorderSide(
                  //           color: Colors.transparent,
                  //           width: 0,
                  //         ),
                  //         shape: RoundedRectangleBorder(
                  //           borderRadius: BorderRadius.all(Radius.circular(8)),
                  //         ),
                  //       ),
                  //       child: Icon(
                  //         Icons.forum_rounded,
                  //         size: 28,
                  //         color: theme.colorTheme.dirtyWhite,
                  //       ),
                  //     ),
                  //   ],
                  // ),
                  OutlinedButton(
                    style: OutlinedButton.styleFrom(
                      minimumSize: Size.zero,
                      foregroundColor: EpicHireTheme.of(context).dirtyWhite,
                      padding: const EdgeInsets.only(
                        top: 12,
                        bottom: 12,
                        left: 8,
                        right: 8,
                      ),
                      side: const BorderSide(
                        color: Colors.transparent,
                        width: 0,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(8)),
                      ),
                    ),
                    onPressed: () {},
                    child: SizedBox(
                      width: double.infinity,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            caption.replaceAll("\n", ""),
                            textAlign: TextAlign.start,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Divider(color: EpicHireTheme.of(context).dirtyWhite),
          ],
        ),
      ),
    );
  }
}
