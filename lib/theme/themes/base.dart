import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

String family = GoogleFonts.inter().fontFamily!;

TextTheme getBaseTextTheme(ColorScheme colorScheme) {
  return ThemeData.dark().textTheme
      .copyWith(
        labelLarge: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 17,
          color: colorScheme.onBackground,
        ),
        labelMedium: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 15,
          color: colorScheme.onBackground,
        ),
        headlineSmall: TextStyle(
          fontWeight: FontWeight.w500,
          fontSize: 16,
          color: colorScheme.onBackground,
        ),
        bodyMedium: TextStyle(
          fontWeight: FontWeight.w500,
          fontSize: 15,
          color: colorScheme.onBackground,
        ),
      )
      .apply(fontFamily: family);
}
