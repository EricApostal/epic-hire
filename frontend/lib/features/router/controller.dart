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
    ShellRoute(
      pageBuilder:
          (context, state, child) => NoTransitionPage(
            child: NavigationFrame(child: child),
            key: state.pageKey,
          ),
      routes: [
        GoRoute(
          path: '/channels/:guildId',
          pageBuilder: (context, state) {
            Snowflake guildId = Snowflake.zero;
            if (state.pathParameters.containsKey('guildId')) {
              var gid = state.pathParameters['guildId']!;
              if (gid != "@me") guildId = Snowflake.parse(gid);
            }
            return NoTransitionPage(
              // todo: DM screen
              child:
                  guildId == Snowflake.zero
                      ? FriendsScreen(channelId: Snowflake.zero)
                      : MessagesScreen(
                        guildId: guildId,
                        channelId: Snowflake.zero,
                      ),
              key: state.pageKey,
            );
          },
        ),
        GoRoute(
          path: '/channels/:guildId/:channelId',
          pageBuilder: (context, state) {
            Snowflake guildId = Snowflake.parse(
              state.pathParameters['guildId']!,
            );
            Snowflake channelId = Snowflake.parse(
              state.pathParameters['channelId']!,
            );

            return NoTransitionPage(
              child: MessagesScreen(guildId: guildId, channelId: channelId),
              key: state.pageKey,
            );
          },
        ),
      ],
    ),
  ],
);

class NoTransitionPage<T> extends CustomTransitionPage<T> {
  NoTransitionPage({required super.child, super.key})
    : super(transitionsBuilder: (_, __, ___, child) => child);
}
