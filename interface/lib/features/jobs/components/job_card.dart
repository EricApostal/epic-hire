import 'package:cached_network_image/cached_network_image.dart';
import 'package:epic_hire/shared/utils/network_key.dart';
import 'package:epic_hire/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wrapper/wrapper.dart';
import 'package:get_time_ago/get_time_ago.dart';

class JobCard extends ConsumerStatefulWidget {
  final Job job;
  final bool isFirstCard;
  const JobCard(this.job, {super.key, this.isFirstCard = false});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _JobCardState();
}

class _JobCardState extends ConsumerState<JobCard>
    with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).custom;
    List<Widget> locations = [];
    for (final location in widget.job.locations) {
      String text = "${location.locality}, ${location.administrativeArea}";
      if (location.isoCountryCode != "US") {
        text += ", ${location.country}";
      }
      locations.add(
        Text(
          text,
          style: theme.textTheme.bodyText1.copyWith(
            color: theme.colorTheme.dirtywhite.withOpacity(0.9),
          ),
        ),
      );
    }

    print(widget.job.category?.name);
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(0)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (widget.isFirstCard)
            SizedBox(height: MediaQuery.of(context).viewPadding.top),
          Row(
            children: [
              if (widget.job.company.imageKey != null)
                SizedBox(
                  width: 35,
                  height: 35,
                  child: ClipOval(
                    child: CachedNetworkImage(
                      imageUrl: getUrlFromImageKey(
                        widget.job.company.imageKey!,
                        width: 128,
                      ),
                    ),
                  ),
                ),
              const SizedBox(width: 8),

              Text(
                widget.job.company.name,
                style: theme.textTheme.caption.copyWith(
                  fontWeight: FontWeight.w600,
                  color: theme.colorTheme.dirtywhite,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            widget.job.title,
            style: theme.textTheme.labelLarge.copyWith(
              fontSize: 18,
              fontWeight: FontWeight.w700,
              color: theme.colorTheme.dirtywhite,
            ),
          ),
          const SizedBox(height: 12),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Expanded(
                child: Wrap(spacing: 4, runSpacing: 2, children: locations),
              ),
              Spacer(),
              Text(
                GetTimeAgo.parse(widget.job.created),
                style: theme.textTheme.caption.copyWith(
                  fontSize: 12,
                  fontStyle: FontStyle.italic,
                  color: theme.colorTheme.dirtywhite.withOpacity(0.8),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
