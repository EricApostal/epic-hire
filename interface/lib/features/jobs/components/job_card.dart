import 'dart:ui';

import 'package:epic_hire/shared/components/image/fade_in.dart';
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
  late final TabController _tabController = TabController(
    length: 1,
    vsync: this,
  );

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
    return Stack(
      children: [
        if (widget.job.company.imageKey != null)
          Positioned.fill(
            child: BlurredImage(imageKey: widget.job.company.imageKey!),
          ),

        Positioned.fill(
          child: Container(
            decoration: BoxDecoration(
              color: const Color.fromARGB(164, 0, 0, 0),
              borderRadius: BorderRadius.circular(0),
            ),
          ),
        ),
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(0)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (widget.isFirstCard)
                SizedBox(height: MediaQuery.of(context).viewPadding.top),
              Row(
                children: [
                  Text(
                    widget.job.company.name,
                    style: theme.textTheme.caption.copyWith(
                      fontWeight: FontWeight.w600,
                      color: theme.colorTheme.dirtywhite,
                    ),
                  ),
                  Text(
                    " · Posted ${GetTimeAgo.parse(widget.job.created)}",
                    style: theme.textTheme.caption.copyWith(
                      fontSize: 12,
                      fontStyle: FontStyle.italic,
                      color: theme.colorTheme.dirtywhite.withOpacity(0.8),
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
              Wrap(spacing: 4, runSpacing: 2, children: locations),
              const SizedBox(height: 16),
              Text(widget.job.summary, style: theme.textTheme.bodyText1),
              const SizedBox(height: 16),

              // TabBarView(controller: _tabController, children: [Text("hi")]),
              OutlinedButton(
                style: OutlinedButton.styleFrom(
                  minimumSize: const Size(double.infinity, 48),
                  backgroundColor: theme.colorTheme.primary.withOpacity(0.9),
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  side: BorderSide(
                    color: theme.colorTheme.dirtywhite.withOpacity(0),
                    width: 0,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  elevation: 2,
                  shadowColor: Colors.black.withOpacity(0.3),
                ),
                onPressed: () {},
                child: Text(
                  "I'm Interested",
                  style: theme.textTheme.bodyText1.copyWith(
                    fontWeight: FontWeight.w600,
                    color: theme.colorTheme.dirtywhite,
                  ),
                ),
              ),
              const SizedBox(height: 12),
              // Divider(
              //   color: theme.colorTheme.dirtywhite.withOpacity(0.2),
              //   height: 1,
              //   thickness: 1,
              // ),
            ],
          ),
        ),
      ],
    );
  }
}

class BlurredImage extends StatelessWidget {
  final String imageKey;
  const BlurredImage({super.key, required this.imageKey});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(0),
      child: ImageFiltered(
        imageFilter: ImageFilter.blur(sigmaX: 36, sigmaY: 36),
        child: CustomFadeInWidget(
          image: Image.network(
            "https://epic-hire.s3.amazonaws.com/$imageKey",
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
