import 'package:epic_hire/features/authentication/views/login.dart';
import 'package:go_router/go_router.dart';

final routerController = GoRouter(
  initialLocation: '/login',
  routes: [
    GoRoute(path: '/', redirect: (_, __) => '/login'),
    GoRoute(
      path: '/login',
      pageBuilder:
          (context, state) =>
              NoTransitionPage(child: const LoginScreen(), key: state.pageKey),
    ),
  ],
);

class NoTransitionPage<T> extends CustomTransitionPage<T> {
  NoTransitionPage({required super.child, super.key})
    : super(transitionsBuilder: (_, __, ___, child) => child);
}
