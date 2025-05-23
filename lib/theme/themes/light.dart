import 'package:epic_hire/theme/color_theme.dart';
import 'package:epic_hire/theme/theme.dart';
import 'package:epic_hire/theme/themes/base.dart';
import 'package:flutter/material.dart';

ThemeData getLightTheme(BuildContext context) {
  final colorScheme = ColorScheme.light();
  return ThemeData.from(colorScheme: colorScheme).copyWith(
    textTheme: getBaseTextTheme(colorScheme).apply(),
    extensions: [
      const EpicHireTheme(
        foreground: AppColorsLight.foreground,
        background: AppColorsLight.background,
        dirtyWhite: AppColorsLight.dirtyWhite,
        white: AppColorsLight.white,
        gray: AppColorsLight.gray,
        darkGray: AppColorsLight.darkGray,
        lightGray: AppColorsLight.lightGray,
        primary: AppColorsLight.primary,
        red: AppColorsLight.red,
        green: AppColorsLight.green,
        yellow: AppColorsLight.yellow,
        purple: AppColorsLight.purple,
        blue: AppColorsLight.blue,
      ),
    ],
  );
}
