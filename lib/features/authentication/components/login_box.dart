import 'package:epic_hire/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginBox extends ConsumerStatefulWidget {
  final String hintText;
  final TextEditingController controller;
  final bool obscureText;

  final List<String>? autofillHints;
  final BorderRadius? borderRadius;
  final BoxBorder? border;

  const LoginBox({
    super.key,
    required this.hintText,
    required this.controller,
    required this.obscureText,
    this.autofillHints,
    this.borderRadius,
    this.border,
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
        color: EpicHireTheme.of(context).foreground,
        borderRadius:
            widget.borderRadius ?? BorderRadius.all(Radius.circular(18)),
        // border: widget.border ?? Border.all(width: 3, color: theme.gray),
      ),
      child: Padding(
        padding: const EdgeInsets.all(0),
        child: TextFormField(
          cursorOpacityAnimates: true,
          style: theme.textTheme.labelMedium!.copyWith(
            color: EpicHireTheme.of(context).dirtyWhite,
          ),
          cursorWidth: 3,
          cursorRadius: Radius.circular(2),
          controller: widget.controller,
          autofillHints: widget.autofillHints,
          obscureText: widget.obscureText,

          decoration: InputDecoration(
            hintStyle: theme.textTheme.labelMedium!.copyWith(
              color: EpicHireTheme.of(context).gray,
            ),
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
