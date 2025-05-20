import 'package:epic_hire/theme/color_theme.dart';
import 'package:epic_hire/theme/theme.dart';
import 'package:epic_hire/theme/themes/base.dart';
import 'package:flutter/material.dart';

ThemeData getLightTheme(BuildContext context) {
  return ThemeData.from(colorScheme: ColorScheme.light()).copyWith(
    textTheme: getBaseTextTheme(context).apply(),
    extensions: [
      const EpicHireTheme(
        foreground: AppColorsLight.foreground,
        background: AppColorsLight.background,
        dirtyWhite: AppColorsLight.dirtyWhite,
        white: AppColorsLight.white,
        gray: AppColorsLight.gray,
        darkGray: AppColorsLight.darkGray,
        primary: AppColorsLight.primary,
        red: AppColorsLight.red,
        green: AppColorsLight.green,
        yellow: AppColorsLight.yellow,
      ),
    ],
  );
}
