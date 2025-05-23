import 'package:epic_hire/features/authentication/views/landing.dart';
import 'package:epic_hire/features/authentication/views/loading.dart';
import 'package:epic_hire/features/authentication/views/login.dart';
import 'package:epic_hire/features/authentication/views/register.dart';
import 'package:epic_hire/features/company/views/summary_view.dart';
import 'package:epic_hire/features/events/views/events.dart';
import 'package:epic_hire/features/home/views/navigation_frame.dart';
import 'package:epic_hire/features/jobs/views/jobs.dart';
import 'package:epic_hire/features/messaging/views/message_list.dart';
import 'package:epic_hire/features/messaging/views/message_overview.dart';
import 'package:epic_hire/features/search/screens/search_screen.dart';
import 'package:epic_hire/features/story/components/story_slider.dart';
import 'package:epic_hire/features/user/views/profile.dart';
import 'package:epic_hire/shared/utils/platform.dart';
import 'package:epic_hire/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

final routerController = GoRouter(
  initialLocation: '/loading',
  routes: [
    ShellRoute(
      builder: (context, state, child) => Scaffold(
        body: child,
        backgroundColor: EpicHireTheme.of(context).background,
      ),
      routes: [
        GoRoute(path: '/', redirect: (_, __) => '/loading'),
        GoRoute(
          path: "/loading",
          pageBuilder: (context, state) => NoTransitionPage<void>(
            key: state.pageKey,
            child: StartupLoadingScreen(),
          ),
        ),
        GoRoute(
          path: '/login',
          pageBuilder: (context, state) => NoTransitionPage<void>(
            key: state.pageKey,
            child: LandingScreen(),
          ),
          routes: [
            GoRoute(
              path: '/existing',
              pageBuilder: (context, state) => NoTransitionPage<void>(
                key: state.pageKey,
                child: LoginScreen(),
              ),
            ),
            GoRoute(
              path: '/register',
              pageBuilder: (context, state) => NoTransitionPage<void>(
                key: state.pageKey,
                child: RegisterScreen(),
              ),
            ),
          ],
        ),
        GoRoute(
          path: '/profile/:userId/stories',
          pageBuilder: (context, state) {
            final index = int.tryParse(
              (state.extra as dynamic)!['startingIndex'] as String,
            );
            return NoTransitionPage<void>(
              key: state.pageKey,
              child: StorySliderScreen(
                startingIndex: index!,
                userId: int.parse(state.pathParameters['userId'] as String),
              ),
            );
          },
        ),
        ShellRoute(
          builder: (context, state, child) => NavigationFrame(
            showNavbar: _shouldShowNavigation(context, state),
            child: child,
          ),
          routes: [
            GoRoute(
              path: "/messages",
              pageBuilder: (context, state) => NoTransitionPage<void>(
                key: state.pageKey,
                child: MessageOverviewScreen(),
              ),
              routes: [
                GoRoute(
                  path: ':conversation_id',
                  pageBuilder: (context, state) {
                    final id = int.tryParse(
                      state.pathParameters["conversation_id"] as String,
                    );
                    return NoTransitionPage<void>(
                      key: state.pageKey,
                      child: shouldUseMobileLayout(context)
                          ? MessageListScreen(conversationId: id!)
                          : MessageOverviewScreen(conversationId: id),
                    );
                  },
                ),
              ],
            ),
            GoRoute(
              path: "/events",
              pageBuilder: (context, state) => NoTransitionPage<void>(
                key: state.pageKey,
                child: EventScreen(),
              ),
            ),
            GoRoute(
              path: "/search",
              pageBuilder: (context, state) => NoTransitionPage<void>(
                key: state.pageKey,
                child: SearchScreen(),
              ),
            ),
            GoRoute(
              path: "/work",
              pageBuilder: (context, state) => NoTransitionPage<void>(
                key: state.pageKey,
                child: SearchScreen(),
              ),
            ),
            GoRoute(
              path: "/companies",
              pageBuilder: (context, state) => NoTransitionPage<void>(
                key: state.pageKey,
                child: CompanySummaryListScreen(),
              ),
            ),
            GoRoute(
              path: "/jobs",
              pageBuilder: (context, state) =>
                  NoTransitionPage<void>(key: state.pageKey, child: JobsList()),
            ),
            GoRoute(
              path: "/network",
              pageBuilder: (context, state) => NoTransitionPage<void>(
                key: state.pageKey,
                child: Center(
                  child: Text(
                    "The network page isn't implemented yet. Sorry about that!",
                  ),
                ),
              ),
            ),
            GoRoute(
              path: "/profile/:userId",
              pageBuilder: (context, state) {
                final userId = int.parse(
                  state.pathParameters['userId'] as String,
                );
                return NoTransitionPage<void>(
                  key: state.pageKey,
                  child: ProfileScreen(userId: userId),
                );
              },
              routes: [],
            ),
          ],
        ),
      ],
    ),
  ],
);

bool _shouldShowNavigation(BuildContext context, GoRouterState state) {
  if (shouldUseMobileLayout(context)) {
    return !state.matchedLocation.startsWith('/messages/');
  }
  return true;
}

class NoTransitionPage<T> extends CustomTransitionPage<T> {
  NoTransitionPage({required super.child, super.key})
    : super(transitionsBuilder: (_, __, ___, child) => child);
}
