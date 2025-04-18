import 'package:epic_hire/features/authentication/views/login.dart';
import 'package:epic_hire/features/company/views/summary_view.dart';
import 'package:epic_hire/features/home/views/home.dart';
import 'package:epic_hire/features/home/views/navigation_frame.dart';
import 'package:epic_hire/features/jobs/views/jobs.dart';
import 'package:epic_hire/features/story/components/story_slider.dart';
import 'package:epic_hire/features/user/views/profile.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

final routerController = GoRouter(
  initialLocation: '/login',
  routes: [
    GoRoute(path: '/', redirect: (_, __) => '/login'),
    GoRoute(path: '/login', builder: (context, state) => LoginScreen()),
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
          path: "/home",
          pageBuilder:
              (context, state) => NoTransitionPage<void>(
                key: state.pageKey,
                child: HomeScreen(),
              ),
        ),
        GoRoute(
          path: "/companies",
          pageBuilder:
              (context, state) => NoTransitionPage<void>(
                key: state.pageKey,
                child: CompanySummaryListScreen(),
              ),
        ),
        GoRoute(
          path: "/jobs",
          pageBuilder:
              (context, state) =>
                  NoTransitionPage<void>(key: state.pageKey, child: JobsList()),
        ),
        GoRoute(
          path: "/network",
          pageBuilder:
              (context, state) => NoTransitionPage<void>(
                key: state.pageKey,
                child: Scaffold(
                  body: Center(
                    child: Text(
                      "The network page isn't implemented yet. Sorry about that!",
                    ),
                  ),
                ),
              ),
        ),
        GoRoute(
          path: "/profile/:userId",
          pageBuilder: (context, state) {
            final userId = int.parse(state.pathParameters['userId'] as String);
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
);

class NoTransitionPage<T> extends CustomTransitionPage<T> {
  NoTransitionPage({required super.child, super.key})
    : super(transitionsBuilder: (_, __, ___, child) => child);
}
