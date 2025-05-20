import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:epic_hire/features/home/components/navigation_bar.dart';
import 'package:epic_hire/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class NavigationFrame extends ConsumerStatefulWidget {
  final Widget child;
  const NavigationFrame({super.key, required this.child});

  @override
  ConsumerState<NavigationFrame> createState() => _OverviewState();
}

class _OverviewState extends ConsumerState<NavigationFrame> {
  @override
  Widget build(BuildContext context) {
    // chat, events, search, jobs
    final icons = [Icons.message, Icons.event, Icons.search, Icons.work];
    final theme = EpicHireTheme.of(context);
    return Scaffold(
      // backgroundColor: EpicHireTheme.of(context).background,
      backgroundColor: Colors.transparent,
      body: widget.child,
      extendBody: true,

      bottomNavigationBar: AnimatedBottomNavigationBar.builder(
        itemCount: icons.length,
        leftCornerRadius: 32,
        rightCornerRadius: 32,
        gapLocation: GapLocation.center,
        notchSmoothness: NotchSmoothness.verySmoothEdge,
        tabBuilder: (index, isActive) {
          return Icon(
            icons[index],
            color: isActive ? theme.dirtyWhite : theme.foreground,
          );
        },
        backgroundColor: theme.background,
        activeIndex: 0,
        onTap: (p0) {},
      ),
    );
  }
}
