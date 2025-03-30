import 'package:epic_hire/theme/theme.dart';
import 'package:flutter/material.dart';

class TitleBar extends StatelessWidget {
  final String titleName;
  final List<Widget>? extraItems;
  const TitleBar(this.titleName, {super.key, this.extraItems});

  @override
  Widget build(BuildContext context) {
    final viewPadding = MediaQuery.of(context).padding;
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Theme.of(context).custom.colorTheme.foreground,
      ),
      child: Padding(
        padding: EdgeInsets.fromLTRB(24, viewPadding.top, 24, 24),
        child: Text(
          titleName,
          style: Theme.of(context).custom.textTheme.titleMedium,
        ),
      ),
    );
  }
}
