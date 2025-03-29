import 'package:epic_hire/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LoginBox extends ConsumerStatefulWidget {
  final String hintText;
  const LoginBox({super.key, required this.hintText});

  @override
  ConsumerState<LoginBox> createState() => _LoginBoxState();
}

class _LoginBoxState extends ConsumerState<LoginBox> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).custom;
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).custom.colorTheme.foreground,
        borderRadius: BorderRadius.all(Radius.circular(12)),
      ),
      child: Padding(
        padding: const EdgeInsets.all(0),
        child: TextFormField(
          style: theme.textTheme.bodyText1,
          decoration: InputDecoration(
            border: InputBorder.none,
            enabledBorder: InputBorder.none,
            focusedBorder: InputBorder.none,
            errorBorder: InputBorder.none,
            disabledBorder: InputBorder.none,
            contentPadding: EdgeInsets.all(18),
            hintText: widget.hintText,
          ),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter some text';
            }
            return null;
          },
        ),
      ),
    );
  }
}
