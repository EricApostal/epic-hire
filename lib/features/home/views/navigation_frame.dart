import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:epic_hire/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class NavigationFrame extends ConsumerStatefulWidget {
  final Widget child;
  const NavigationFrame({super.key, required this.child});

  static NavigationFrameState? of(BuildContext context) {
    return context.findAncestorStateOfType<NavigationFrameState>();
  }

  @override
  ConsumerState<NavigationFrame> createState() => NavigationFrameState();
}

class NavigationFrameState extends ConsumerState<NavigationFrame>
    with SingleTickerProviderStateMixin {
  late AnimationController _gapAnimationController;
  late Animation<double> _gapWidthAnimation;
  Widget? _floatingActionButton;
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    _gapAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );

    _gapWidthAnimation = Tween<double>(begin: 0, end: 72).animate(
      CurvedAnimation(parent: _gapAnimationController, curve: Curves.easeInOut),
    );
  }

  void setFloatingActionButton(Widget? fab) {
    if (fab != null) {
      setState(() => _floatingActionButton = fab);
      _gapAnimationController.forward();
    } else {
      _gapAnimationController.reverse().then((_) {
        if (mounted) setState(() => _floatingActionButton = null);
      });
    }
  }

  void setActiveIndex(int index) {
    setState(() => _currentIndex = index);
  }

  @override
  void dispose() {
    _gapAnimationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final icons = [
      Icons.message_rounded,
      Icons.event_rounded,
      Icons.search_rounded,
      Icons.work_rounded,
    ];
    final theme = EpicHireTheme.of(context);

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: widget.child,
      extendBody: true,
      floatingActionButton: _floatingActionButton,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: AnimatedBuilder(
        animation: _gapWidthAnimation,
        builder: (context, child) {
          return AnimatedBottomNavigationBar.builder(
            backgroundColor: theme.foreground,
            itemCount: icons.length,
            leftCornerRadius: 18,
            height: 75,
            gapWidth: _floatingActionButton != null
                ? _gapWidthAnimation.value
                : 0,
            rightCornerRadius: 18,
            gapLocation: GapLocation.center,
            notchSmoothness: NotchSmoothness.verySmoothEdge,
            tabBuilder: (index, isActive) {
              return Icon(
                icons[index],
                size: 24,
                color: isActive
                    ? theme.white
                    : theme.white.withValues(alpha: 0.6),
              );
            },
            activeIndex: _currentIndex,
            onTap: setActiveIndex,
          );
        },
      ),
    );
  }
}
