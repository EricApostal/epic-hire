import 'package:epic_hire/theme/theme.dart';
import 'package:flutter/material.dart';

class EventScreen extends StatefulWidget {
  const EventScreen({super.key});

  @override
  State<EventScreen> createState() => _EventScreenState();
}

class _EventScreenState extends State<EventScreen> {
  @override
  Widget build(BuildContext context) {
    // final colorTheme = EpicHireTheme.of(context);
    return Scaffold(body: Center(child: const Text("EVENTS!!")));
  }
}
