import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class StoryView extends ConsumerStatefulWidget {
  const StoryView({super.key});

  @override
  ConsumerState<StoryView> createState() => _StoryViewState();
}

class _StoryViewState extends ConsumerState<StoryView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: const Placeholder());
  }
}
