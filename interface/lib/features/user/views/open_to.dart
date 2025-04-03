import 'package:epic_hire/features/user/repositories/user.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class OpenToScreen extends ConsumerStatefulWidget {
  final int userId;
  const OpenToScreen({super.key, required this.userId});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _OpenToScreenState();
}

class _OpenToScreenState extends ConsumerState<OpenToScreen> {
  @override
  Widget build(BuildContext context) {
    final user = ref.watch(epicUserProvider(widget.userId)).valueOrNull;
    // TODO: "Open To" needs to be models, not dynamic.
    return Container();
  }
}
