import 'package:epic_hire/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class StyledTextButton extends StatefulWidget {
  final void Function() callback;
  final String text;
  final Color backgroundColor;
  final BorderRadius? borderRadius;

  const StyledTextButton(
    this.text, {
    super.key,
    required this.callback,
    required this.backgroundColor,
    this.borderRadius,
  });

  @override
  State<StyledTextButton> createState() => _StyledTextButtonState();
}

class _StyledTextButtonState extends State<StyledTextButton> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashFactory: NoSplash.splashFactory,
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      focusColor: Colors.transparent,
      hoverColor: Colors.transparent,
      onTap: () {
        HapticFeedback.mediumImpact();
        widget.callback();
      },
      child: Container(
        decoration: BoxDecoration(
          color: widget.backgroundColor,
          borderRadius: widget.borderRadius ?? BorderRadius.circular(16),
        ),
        // text input
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Center(
            child: Text(
              widget.text,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ),
        ),
      ),
    );
  }
}
