import 'package:epic_hire/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LoginBox extends ConsumerStatefulWidget {
  final String hintText;
  final TextEditingController controller;
  final List<String>? autofillHints;
  final bool obscureText;
  const LoginBox({
    super.key,
    required this.hintText,
    required this.controller,
    required this.obscureText,
    this.autofillHints,
  });

  @override
  ConsumerState<LoginBox> createState() => _LoginBoxState();
}

class _LoginBoxState extends ConsumerState<LoginBox> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      decoration: BoxDecoration(
        color: EpicHireTheme.of(context).dirtyWhite.withValues(alpha: 1),
        borderRadius: BorderRadius.all(Radius.circular(16)),
      ),
      child: Padding(
        padding: const EdgeInsets.all(0),
        child: TextFormField(
          style: Theme.of(
            context,
          ).textTheme.bodyMedium!.copyWith(fontWeight: FontWeight.bold),
          controller: widget.controller,
          autofillHints: widget.autofillHints,
          obscureText: widget.obscureText,

          decoration: InputDecoration(
            hintStyle: Theme.of(
              context,
            ).textTheme.bodyMedium!.copyWith(fontWeight: FontWeight.w500),
            border: InputBorder.none,
            enabledBorder: InputBorder.none,
            focusedBorder: InputBorder.none,
            errorBorder: InputBorder.none,
            disabledBorder: InputBorder.none,
            contentPadding: EdgeInsets.all(22),
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
