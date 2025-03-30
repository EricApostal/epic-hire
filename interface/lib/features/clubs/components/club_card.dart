import 'package:epic_hire/shared/components/image/fade_in.dart';
import 'package:epic_hire/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wrapper/wrapper.dart';

class ClubCard extends ConsumerStatefulWidget {
  final Club club;
  const ClubCard(this.club, {super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ClubCardState();
}

class _ClubCardState extends ConsumerState<ClubCard> {
  @override
  Widget build(BuildContext context) {
    final caption = widget.club.description ?? "View more";
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                OutlinedButton(
                  style: OutlinedButton.styleFrom(
                    minimumSize: Size.zero,
                    foregroundColor:
                        Theme.of(context).custom.colorTheme.dirtywhite,
                    padding: const EdgeInsets.only(
                      top: 12,
                      bottom: 12,
                      left: 8,
                      right: 8,
                    ),
                    side: const BorderSide(color: Colors.transparent, width: 0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(8)),
                    ),
                  ),
                  onPressed: () {},

                  child: Text(
                    widget.club.name,
                    style: Theme.of(context).custom.textTheme.bodyText1,
                  ),
                ),
              ],
            ),
          ),
          if (widget.club.logoKey != null)
            CustomFadeInWidget(
              image: Image.network(
                "https://epic-hire.s3.amazonaws.com/${widget.club.logoKey!}",
                fit: BoxFit.cover,
                height: 200,
                width: double.infinity,
              ),
            ),
          Padding(
            padding: const EdgeInsets.fromLTRB(8, 8, 8, 0),
            child: OutlinedButton(
              style: OutlinedButton.styleFrom(
                minimumSize: Size.zero,
                foregroundColor: Theme.of(context).custom.colorTheme.dirtywhite,
                padding: const EdgeInsets.only(
                  top: 12,
                  bottom: 12,
                  left: 8,
                  right: 8,
                ),
                side: const BorderSide(color: Colors.transparent, width: 0),
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
          ),
          Divider(color: Theme.of(context).custom.colorTheme.dirtywhite),
        ],
      ),
    );
  }
}
