import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

String family = GoogleFonts.inter().fontFamily!;

TextTheme getBaseTextTheme(BuildContext context) {
  return Theme.of(context).textTheme
      .apply(fontFamily: family)
      .copyWith(
        labelLarge: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
        labelMedium: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
      );
}


/**
  return TextTheme(
    displayLarge: TextStyle(
      fontSize: 36,
      fontFamily: family,
      fontWeight: FontWeight.w500,
    ),
    displayMedium: TextStyle(
      fontSize: 20,
      fontFamily: family,
      fontWeight: FontWeight.w500,
    ),
    displaySmall: TextStyle(
      fontSize: 15,
      fontFamily: family,
      fontWeight: FontWeight.w500,
    ),
    titleLarge: TextStyle(
      fontSize: 36,
      fontFamily: family,
      fontWeight: FontWeight.w500,
      // color: Colors.white,
    ),
    titleMedium: TextStyle(
      fontSize: 20,
      fontFamily: family,
      fontWeight: FontWeight.w500,
      // color: Colors.white,
    ),
    titleSmall: TextStyle(
      fontSize: 15,
      fontFamily: family,
      fontWeight: FontWeight.w500,
      // color: Colors.white,
    ),
    headlineLarge: TextStyle(
      fontSize: 18,
      fontWeight: FontWeight.w500,
      fontFamily: family,
    ),
    labelLarge: TextStyle(
      fontSize: 15,
      fontWeight: FontWeight.w500,
      fontFamily: family,
      // color: const Color(0xFFBDBDBD),
    ),
    labelMedium: TextStyle(
      fontSize: 12,
      fontFamily: family,
      fontWeight: FontWeight.w500,
      // color: const Color(0xFFBDBDBD),
    ),
    bodyLarge: TextStyle(
      fontSize: 15,
      fontFamily: family,
      // color: const Color.fromARGB(255, 255, 255, 255),
      fontWeight: FontWeight.w500,
    ),
    bodyMedium: TextStyle(
      fontSize: 14,
      fontFamily: family,
      // color: const Color(0xFFBDBDBD),
      fontWeight: FontWeight.w500,
    ),
  );
 */