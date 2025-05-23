import 'package:epic_hire/theme/color_theme.dart';
import 'package:epic_hire/theme/theme.dart';
import 'package:epic_hire/theme/themes/base.dart';
import 'package:flutter/material.dart';
import 'package:universal_platform/universal_platform.dart';

bool useAmoled = false;

ThemeData getDarkTheme(BuildContext context) {
  final colorScheme = ColorScheme.dark(primary: AppColorsAmoled.blue);
  return ThemeData.from(colorScheme: colorScheme).copyWith(
    textTheme: getBaseTextTheme(colorScheme),
    scaffoldBackgroundColor: (UniversalPlatform.isMobile && useAmoled)
        ? AppColorsAmoled.background
        : AppColorsDark.background,

    extensions: [
      (UniversalPlatform.isMobile && useAmoled)
          ? const EpicHireTheme(
              foreground: AppColorsAmoled.foreground,
              background: AppColorsAmoled.background,
              dirtyWhite: AppColorsAmoled.dirtyWhite,
              white: AppColorsAmoled.white,
              gray: AppColorsAmoled.gray,
              darkGray: AppColorsAmoled.darkGray,
              lightGray: AppColorsAmoled.lightGray,
              primary: AppColorsAmoled.primary,
              red: AppColorsAmoled.red,
              green: AppColorsAmoled.green,
              yellow: AppColorsAmoled.yellow,
              purple: AppColorsAmoled.purple,
              blue: AppColorsAmoled.blue,
            )
          : const EpicHireTheme(
              foreground: AppColorsDark.foreground,
              background: AppColorsDark.background,
              dirtyWhite: AppColorsDark.dirtyWhite,
              white: AppColorsDark.white,
              gray: AppColorsDark.gray,
              darkGray: AppColorsDark.darkGray,
              lightGray: AppColorsDark.lightGray,
              primary: AppColorsDark.primary,
              red: AppColorsDark.red,
              green: AppColorsDark.green,
              yellow: AppColorsDark.yellow,
              purple: AppColorsDark.purple,
              blue: AppColorsDark.blue,
            ),
    ],
  );
}
