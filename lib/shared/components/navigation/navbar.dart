import 'package:epic_hire/shared/utils/platform.dart';
import 'package:epic_hire/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class DynamicNavigationBar extends ConsumerStatefulWidget {
  const DynamicNavigationBar({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _DynamicNavigationBarState();
}

class _DynamicNavigationBarState extends ConsumerState<DynamicNavigationBar> {
  final routes = ["messages", "events", "search", "work"];
  bool showNavbar = true;

  int _selectedIndex = 0;

  final navigationBarDestinations = [
    NavigationDestination(icon: Icon(Icons.message_rounded), label: "Chat"),
    NavigationDestination(icon: Icon(Icons.event), label: "Events"),
    NavigationDestination(icon: Icon(Icons.search), label: "Search"),
    NavigationDestination(icon: Icon(Icons.work), label: "Jobs"),
  ];

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
    final textTheme = Theme.of(context).textTheme;

    if (shouldUseDesktopLayout(context)) {
      final navigationRailDestinations = navigationBarDestinations.map((dest) {
        return NavigationRailDestination(
          icon: dest.icon,
          label: Text(dest.label),
        );
      }).toList();

      return Row(
        children: [
          if (showNavbar)
            NavigationRail(
              backgroundColor: theme.background,
              selectedIndex: _selectedIndex,
              onDestinationSelected: (value) {
                context.go("/${routes[value]}");
                setState(() {
                  _selectedIndex = value;
                });
              },
              destinations: navigationRailDestinations,
              labelType: NavigationRailLabelType.all,
              indicatorColor: theme.blue.withValues(alpha: 0.6),
              selectedIconTheme: IconThemeData(color: theme.dirtyWhite),
              unselectedIconTheme: IconThemeData(color: theme.gray),
              selectedLabelTextStyle: textTheme.labelMedium!.copyWith(
                color: theme.dirtyWhite,
              ),
              unselectedLabelTextStyle: textTheme.labelMedium!.copyWith(
                color: theme.gray,
              ),
            ),
          VerticalDivider(thickness: 1, width: 1, color: theme.foreground),
        ],
      );
    }

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Divider(height: 1, thickness: 2, color: theme.foreground),
        NavigationBarTheme(
          data: NavigationBarThemeData(
            iconTheme: WidgetStateProperty.resolveWith<IconThemeData?>((
              states,
            ) {
              if (states.contains(WidgetState.selected)) {
                return IconThemeData(color: theme.dirtyWhite);
              }
              return IconThemeData(color: theme.gray);
            }),
            labelTextStyle: WidgetStateProperty.resolveWith<TextStyle?>((
              states,
            ) {
              if (states.contains(WidgetState.selected)) {
                return textTheme.labelMedium!.copyWith(color: theme.dirtyWhite);
              }
              return textTheme.labelMedium!.copyWith(color: theme.gray);
            }),
          ),
          child: NavigationBar(
            backgroundColor: theme.background,
            destinations: navigationBarDestinations,
            indicatorColor: theme.blue.withValues(alpha: 0.6),
            selectedIndex: _selectedIndex,
            onDestinationSelected: (value) {
              context.go("/${routes[value]}");
              setState(() {
                _selectedIndex = value;
              });
            },
          ),
        ),
      ],
    );
  }
}
