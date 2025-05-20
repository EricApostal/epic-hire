import 'package:epic_hire/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class NavigationFrame extends ConsumerStatefulWidget {
  final Widget child;
  const NavigationFrame({super.key, required this.child});

  @override
  ConsumerState<NavigationFrame> createState() => NavigationFrameState();
}

class NavigationFrameState extends ConsumerState<NavigationFrame> {
  final routes = ["messages", "events", "search", "work"];

  int _selectedIndex = 0;

  @override
  void initState() {
    final router = GoRouter.of(context).routerDelegate;
    router.addListener(() {
      final baseRoute = router.currentConfiguration.uri.pathSegments[0];
      setState(() {
        _selectedIndex = routes.indexOf(baseRoute);
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final theme = EpicHireTheme.of(context);

    // chat, events, search, jobs
    final destinations = [
      NavigationDestination(icon: Icon(Icons.message_rounded), label: "Chat"),
      NavigationDestination(icon: Icon(Icons.event), label: "Event"),
      NavigationDestination(icon: Icon(Icons.search), label: "Search"),
      NavigationDestination(icon: Icon(Icons.work), label: "Jobs"),
    ];

    return Scaffold(
      backgroundColor: EpicHireTheme.of(context).background,
      // backgroundColor: Colors.transparent,
      body: widget.child,

      bottomNavigationBar: NavigationBar(
        backgroundColor: theme.foreground,
        destinations: destinations,
        indicatorColor: theme.blue.withValues(alpha: 1),
        selectedIndex: _selectedIndex,
        onDestinationSelected: (value) {
          context.go("/${routes[value]}");
          setState(() {
            _selectedIndex = value;
          });
        },
      ),
    );
  }
}
