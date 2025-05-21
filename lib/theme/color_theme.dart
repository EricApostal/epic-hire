import 'dart:ui';
import 'package:flutter/material.dart';

class StandardColors {
  static const red = Color(0xFFFF5D76);
  static const purple = Color(0xFF826EFF);
  static const green = Color(0xFF00CC91);
  static const blue = Color(0xFF0095FF);
}

class AppColorsDark {
  static const background = Color(0xFF14161A);
  static const foreground = Color(0xFF21252B);
  static const dirtyWhite = Color(0xFFE4E5E8);
  static const white = Color.fromARGB(255, 255, 255, 255);
  static const gray = Color.fromARGB(255, 94, 97, 109);
  static const lightGray = Color.fromARGB(255, 142, 146, 158);
  static const darkGray = Color(0xFF18191f);
  static const primary = Color(0xff2448BE);
  static const blue = StandardColors.blue;
  static const red = StandardColors.red;
  static const green = StandardColors.green;
  static const purple = StandardColors.purple;
  static const yellow = Color(0xFFFEE75C);
}

class AppColorsAmoled {
  static const background = Color(0xFF000000);
  static const foreground = Color(0xFF14161A);
  static const dirtyWhite = Color(0xFFE4E5E8);
  static const white = Color.fromARGB(255, 255, 255, 255);
  static const gray = Color(0xFF818491);
  static const lightGray = Color.fromARGB(255, 180, 184, 199);
  static const darkGray = Color(0xFF18191f);
  static const primary = Color(0xff2448BE);
  static const blue = StandardColors.blue;
  static const red = StandardColors.red;
  static const green = StandardColors.green;
  static const purple = StandardColors.purple;
  static const yellow = Color(0xFFFEE75C);
}

class AppColorsLight {
  static const background = Color.fromARGB(255, 255, 255, 255);
  static const foreground = Color.fromARGB(255, 208, 214, 225);
  static const dirtyWhite = Color(0xFFE4E5E8);
  static const white = Color.fromARGB(255, 255, 255, 255);
  static const gray = Color(0xFF818491);
  static const lightGray = Color.fromARGB(255, 180, 184, 199);
  static const darkGray = Color(0xFF18191f);
  static const primary = Color(0xff2448BE);
  static const blue = StandardColors.blue;
  static const red = StandardColors.red;
  static const green = StandardColors.green;
  static const purple = StandardColors.purple;
  static const yellow = Color(0xFFFEE75C);
}

class ColorTheme {
  final Color background;
  final Color foreground;
  final Color dirtyWhite;
  final Color gray;
  final Color darkGray;
  final Color primary;
  final Color red;
  final Color green;
  final Color yellow;

  ColorTheme({
    required this.background,
    required this.foreground,
    required this.dirtyWhite,
    required this.gray,
    required this.darkGray,
    required this.primary,
    required this.red,
    required this.green,
    required this.yellow,
  });
}
