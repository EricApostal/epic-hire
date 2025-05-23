import 'package:epic_hire/shared/utils/platform.dart';
import 'package:epic_hire/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

class MessageBar extends ConsumerStatefulWidget {
  final int conversationId;
  const MessageBar(this.conversationId, {super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _MessageBarState();
}

class _MessageBarState extends ConsumerState<MessageBar> {
  late TextEditingController messageBarController;
  late FocusNode messageBarFocusNode;
  bool _isShiftPressed = false;

  @override
  void initState() {
    super.initState();
    messageBarController = TextEditingController();
    messageBarFocusNode = FocusNode();
  }

  @override
  void dispose() {
    messageBarController.dispose();
    messageBarFocusNode.dispose();
    super.dispose();
  }

  void _handleKeyEvent(KeyEvent event, bool isDesktop) {
    if (event is KeyDownEvent) {
      if (event.physicalKey == PhysicalKeyboardKey.shiftLeft ||
          event.physicalKey == PhysicalKeyboardKey.shiftRight) {
        setState(() => _isShiftPressed = true);
      } else if (event.physicalKey == PhysicalKeyboardKey.enter &&
          !_isShiftPressed &&
          isDesktop) {
        _sendMessage();
      }
    } else if (event is KeyUpEvent) {
      if (event.physicalKey == PhysicalKeyboardKey.shiftLeft ||
          event.physicalKey == PhysicalKeyboardKey.shiftRight) {
        setState(() => _isShiftPressed = false);
      }
    }
  }

  void _sendMessage() {}

  @override
  Widget build(BuildContext context) {
    final colorTheme = EpicHireTheme.of(context);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
      child: Row(
        children: [
          Container(
            decoration: BoxDecoration(
              color: colorTheme.foreground,
              shape: BoxShape.circle,
            ),
            //child: Icon(Icons.send_rounded),
            child: InkWell(
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Icon(Icons.add_rounded, color: colorTheme.dirtyWhite),
              ),
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: colorTheme.foreground,
                borderRadius: BorderRadius.circular(12),
              ),
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxHeight: 4 * 24),
                child: TextSelectionTheme(
                  data: TextSelectionThemeData(
                    cursorColor: EpicHireTheme.of(context).primary,
                    selectionColor: EpicHireTheme.of(context).primary,
                    selectionHandleColor: EpicHireTheme.of(context).primary,
                  ),
                  child: KeyboardListener(
                    focusNode: FocusNode(),
                    onKeyEvent: (event) =>
                        _handleKeyEvent(event, shouldUseDesktopLayout(context)),
                    child: TextField(
                      focusNode: messageBarFocusNode,
                      controller: messageBarController,
                      maxLines: null,
                      minLines: 1,
                      keyboardType: TextInputType.multiline,
                      textInputAction: TextInputAction.newline,
                      onSubmitted: (_) => {print("Should send message")},
                      inputFormatters: [
                        EnterKeyFormatter(
                          isShiftPressed: _isShiftPressed,
                          isDesktop: shouldUseDesktopLayout(context),
                        ),
                      ],
                      readOnly: false,
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 8,
                        ),
                        hintText: "Send message",
                        hintStyle: GoogleFonts.publicSans(
                          color: EpicHireTheme.of(context).gray,
                          fontWeight: FontWeight.w600,
                        ),
                        border: InputBorder.none,
                        isCollapsed: false,
                      ),
                      style: GoogleFonts.publicSans(
                        color: const Color(0xFFBDBDBD),
                        fontWeight: FontWeight.w500,
                        fontSize: 14.5,
                      ),
                      // cursorColor: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(width: 8),
          Container(
            decoration: BoxDecoration(
              color: colorTheme.blue,
              shape: BoxShape.circle,
            ),
            //child: Icon(Icons.send_rounded),
            child: InkWell(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Icon(Icons.send_rounded),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class EnterKeyFormatter extends TextInputFormatter {
  final bool isShiftPressed;
  final bool isDesktop;

  EnterKeyFormatter({required this.isShiftPressed, required this.isDesktop});

  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    if (newValue.text.endsWith('\n') && !isShiftPressed && isDesktop) {
      return oldValue;
    }
    return newValue;
  }
}
