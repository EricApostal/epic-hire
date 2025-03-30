import 'package:epic_hire/features/authentication/repositories/login.dart';
import 'package:epic_hire/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wrapper/wrapper.dart';

class TitleBar extends ConsumerWidget {
  final String titleName;
  final List<Widget>? extraItems;
  const TitleBar(this.titleName, {super.key, this.extraItems});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final viewPadding = MediaQuery.of(context).padding;
    final client = ref.watch(authenticationProvider).valueOrNull;
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Theme.of(context).custom.colorTheme.foreground,
      ),
      child: Padding(
        padding: EdgeInsets.fromLTRB(24, viewPadding.top, 24, 24),
        child: Row(
          children: [
            Text(
              titleName,
              style: Theme.of(context).custom.textTheme.titleMedium,
            ),
            Spacer(),
            ...extraItems ?? [],
            Text((client?.user as User?)?.lastName ?? "No Acc"),
          ],
        ),
      ),
    );
  }
}
