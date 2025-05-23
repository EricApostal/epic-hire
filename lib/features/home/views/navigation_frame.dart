import 'package:epic_hire/shared/components/navigation/navbar.dart';
import 'package:epic_hire/shared/utils/platform.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class NavigationFrame extends ConsumerStatefulWidget {
  final Widget child;
  const NavigationFrame({super.key, required this.child});

  @override
  ConsumerState<NavigationFrame> createState() => NavigationFrameState();
}

class NavigationFrameState extends ConsumerState<NavigationFrame> {
  @override
  Widget build(BuildContext context) {
    if (shouldUseDesktopLayout(context)) {
      return Row(
        children: [
          DynamicNavigationBar(),
          Expanded(child: widget.child),
        ],
      );
    }
    return Scaffold(body: widget.child);
  }
}
