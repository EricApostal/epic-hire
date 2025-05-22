import 'package:epic_hire/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AppSearchBar extends ConsumerStatefulWidget {
  const AppSearchBar({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _AppSearchBarState();
}

class _AppSearchBarState extends ConsumerState<AppSearchBar> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final ehTheme = EpicHireTheme.of(context);
    return Row(
      children: [
        Expanded(
          child: SearchBar(
            leading: Icon(Icons.search, color: ehTheme.dirtyWhite),
            padding: WidgetStatePropertyAll(
              EdgeInsets.symmetric(horizontal: 12),
            ),
            hintText: "Jump to or search...",
            hintStyle: WidgetStatePropertyAll(
              theme.textTheme.labelMedium!.copyWith(color: ehTheme.gray),
            ),
            shape: WidgetStatePropertyAll(
              RoundedRectangleBorder(
                borderRadius: BorderRadiusGeometry.all(Radius.circular(18)),
              ),
            ),
          ),
        ),
        IconButton(onPressed: () {}, icon: Icon(Icons.filter_list_rounded)),
      ],
    );
  }
}
