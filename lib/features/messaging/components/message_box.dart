import 'package:cached_network_image/cached_network_image.dart';
import 'package:epic_hire/shared/utils/network_key.dart';
import 'package:epic_hire/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:markdown_viewer/markdown_viewer.dart';
import 'package:wrapper/wrapper.dart';

class MessageBox extends ConsumerStatefulWidget {
  final Message message;
  const MessageBox(this.message, {super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _MessageBoxState();
}

class _MessageBoxState extends ConsumerState<MessageBox> {
  MarkdownStyle getMarkdownStyleSheet(BuildContext context) {
    final textColor = EpicHireTheme.of(context).dirtyWhite;
    return MarkdownStyle(
      paragraph: GoogleFonts.publicSans(
        fontSize: 14.5,
        fontWeight: FontWeight.w400,
        color: textColor,
      ),
      codeBlock: GoogleFonts.jetBrainsMono(fontSize: 14),
      codeblockDecoration: BoxDecoration(
        color: EpicHireTheme.of(context).foreground,
        borderRadius: BorderRadius.circular(8),
      ),
      codeSpan: GoogleFonts.jetBrainsMono(
        backgroundColor: EpicHireTheme.of(context).foreground,
        fontSize: 14,
      ),
      list: GoogleFonts.publicSans(
        fontSize: 14.5,
        fontWeight: FontWeight.w500,
        color: textColor,
      ),
      listItem: GoogleFonts.publicSans(
        fontSize: 14.5,
        fontWeight: FontWeight.w500,
        color: textColor,
      ),
      headline1: GoogleFonts.publicSans(
        fontSize: 30,
        fontWeight: FontWeight.bold,
        color: textColor,
      ),
      headline2: GoogleFonts.publicSans(
        fontSize: 24,
        fontWeight: FontWeight.bold,
        color: textColor,
      ),
      headline3: GoogleFonts.publicSans(
        fontSize: 20,
        fontWeight: FontWeight.bold,
        color: textColor,
      ),
      headline4: GoogleFonts.publicSans(
        fontSize: 18,
        fontWeight: FontWeight.bold,
        color: textColor,
      ),
      headline5: GoogleFonts.publicSans(
        fontSize: 16,
        fontWeight: FontWeight.bold,
        color: textColor,
      ),
      headline6: GoogleFonts.publicSans(
        fontSize: 14,
        fontWeight: FontWeight.bold,
        color: textColor,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final colorTheme = EpicHireTheme.of(context);
    final theme = Theme.of(context);
    return OutlinedButton(
      onPressed: () {},
      style: OutlinedButton.styleFrom(
        padding: EdgeInsets.zero,
        backgroundColor: Colors.transparent,
        minimumSize: Size.zero,
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        side: BorderSide.none,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        // change hover / select color to white
        foregroundColor: colorTheme.foreground,
      ),

      child: Padding(
        padding: const EdgeInsets.only(left: 8.0, right: 8, top: 8, bottom: 8),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: 48,
              height: 48,
              child: ClipRRect(
                borderRadius: BorderRadiusGeometry.all(Radius.circular(12)),
                child: CachedNetworkImage(
                  fit: BoxFit.cover,
                  imageUrl: getUrlFromImageKey(
                    widget.message.sender.imageKey,
                    width: 256,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.message.sender.displayName,
                    style: theme.textTheme.labelMedium,
                  ),

                  MarkdownViewer(
                    widget.message.content!,
                    enableTaskList: true,
                    selectable: false,
                    enableSuperscript: false,
                    enableSubscript: false,
                    enableFootnote: false,
                    enableImageSize: false,
                    enableKbd: false,
                    styleSheet: getMarkdownStyleSheet(context),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
