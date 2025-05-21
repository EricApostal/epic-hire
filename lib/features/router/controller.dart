import 'package:epic_hire/features/authentication/views/landing.dart';
import 'package:epic_hire/features/authentication/views/loading.dart';
import 'package:epic_hire/features/authentication/views/login.dart';
import 'package:epic_hire/features/authentication/views/register.dart';
import 'package:epic_hire/features/company/views/summary_view.dart';
import 'package:epic_hire/features/events/views/events.dart';
import 'package:epic_hire/features/home/views/navigation_frame.dart';
import 'package:epic_hire/features/jobs/views/jobs.dart';
import 'package:epic_hire/features/messaging/views/direct_messages.dart';
import 'package:epic_hire/features/search/screens/search_screen.dart';
import 'package:epic_hire/features/story/components/story_slider.dart';
import 'package:epic_hire/features/user/views/profile.dart';
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
          builder: (context, state) => StartupLoadingScreen(),
        ),
        GoRoute(
          path: '/login',
          builder: (context, state) => LandingScreen(),
          routes: [
            GoRoute(
              path: '/existing',
              builder: (context, state) => LoginScreen(),
            ),
            GoRoute(
              path: '/register',
              builder: (context, state) => RegisterScreen(),
            ),
          ],
        ),
        GoRoute(
          path: '/profile/:userId/stories',
          builder: (context, state) {
            final index = int.tryParse(
              (state.extra as dynamic)!['startingIndex'] as String,
            );
            return StorySliderScreen(
              startingIndex: index!,
              userId: int.parse(state.pathParameters['userId'] as String),
            );
          },
        ),
        ShellRoute(
          builder: (context, state, child) => NavigationFrame(child: child),
          routes: [
            GoRoute(
              path: "/messages",
              builder: (context, state) => DirectMessagesScreen(),
            ),
            GoRoute(
              path: "/events",
              builder: (context, state) => EventScreen(),
            ),
            GoRoute(
              path: "/search",
              builder: (context, state) => SearchScreen(),
            ),
            GoRoute(path: "/work", builder: (context, state) => SearchScreen()),
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

class NoTransitionPage<T> extends CustomTransitionPage<T> {
  NoTransitionPage({required super.child, super.key})
    : super(transitionsBuilder: (_, __, ___, child) => child);
}
