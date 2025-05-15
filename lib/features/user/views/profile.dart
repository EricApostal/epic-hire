import 'package:epic_hire/features/user/repositories/user.dart';
import 'package:epic_hire/features/user/views/open_to.dart';
import 'package:epic_hire/features/user/views/resume.dart';
import 'package:epic_hire/features/user/views/story_cards.dart';
import 'package:epic_hire/shared/components/image/fade_in.dart';
import 'package:epic_hire/shared/utils/network_key.dart';
import 'package:epic_hire/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wrapper/wrapper.dart';

class ProfileScreen extends ConsumerStatefulWidget {
  final int userId;
  const ProfileScreen({super.key, required this.userId});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends ConsumerState<ProfileScreen>
    with SingleTickerProviderStateMixin {
  late final TabController _tabController;

  @override
  void initState() {
    _tabController = TabController(length: 3, vsync: this);
    return super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final User? user = ref.watch(epicUserProvider(widget.userId)).valueOrNull;
    if (user == null) {
      return Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    return Scaffold(
      body: Padding(
        padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top + 16),
        child: Container(
          decoration: BoxDecoration(
            color: Theme.of(context).custom.colorTheme.background,
          ),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: 100,
                      child: ClipOval(
                        child: CustomFadeInWidget(
                          image: Image.network(
                            width: 100,
                            height: 100,
                            getUrlFromImageKey(user.imageKey!, width: 256),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "${user.firstName} ${user.lastName}",
                            style:
                                Theme.of(context).custom.textTheme.titleLarge,
                          ),
                          const SizedBox(height: 4),
                          Text(
                            "${user.userSchools.first.school.name ?? user.userSchools.first.adHocSchoolName ?? 'No School Assigned'} · Year Of ${user.userSchools.first.graduationYear}",
                            style: Theme.of(context).custom.textTheme.subtitle1,
                            softWrap: true,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 16),

              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TabBar(
                      controller: _tabController,
                      labelPadding: const EdgeInsets.symmetric(horizontal: 8.0),
                      indicatorSize: TabBarIndicatorSize.tab,
                      indicatorColor:
                          Theme.of(context).custom.colorTheme.primary,
                      labelColor: Colors.white,
                      splashFactory: NoSplash.splashFactory,
                      splashBorderRadius: BorderRadius.circular(8),
                      onTap: (index) {
                        HapticFeedback.lightImpact();
                      },
                      tabs: [
                        const Tab(text: "Story"),
                        const Tab(text: "Resume"),
                        const Tab(text: "Open To"),
                      ],
                    ),
                    Expanded(
                      child: TabBarView(
                        controller: _tabController,
                        children: [
                          StoryCardPage(userId: widget.userId),
                          ResumeScreen(userId: widget.userId),
                          OpenToScreen(userId: widget.userId),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
