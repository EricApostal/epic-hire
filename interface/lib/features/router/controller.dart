import 'package:epic_hire/features/authentication/views/login.dart';
import 'package:epic_hire/features/company/views/summary_view.dart';
import 'package:epic_hire/features/home/views/home.dart';
import 'package:epic_hire/features/home/views/navigation_frame.dart';
import 'package:epic_hire/features/jobs/views/jobs.dart';
import 'package:go_router/go_router.dart';

final routerController = GoRouter(
  initialLocation: '/login',
  routes: [
    GoRoute(path: '/', redirect: (_, __) => '/login'),
    GoRoute(path: '/login', builder: (context, state) => LoginScreen()),
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
      ],
    ),
  ],
);

class NoTransitionPage<T> extends CustomTransitionPage<T> {
  NoTransitionPage({required super.child, super.key})
    : super(transitionsBuilder: (_, __, ___, child) => child);
}
