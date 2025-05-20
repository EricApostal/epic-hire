import 'package:epic_hire/theme/color_theme.dart';
import 'package:epic_hire/theme/theme.dart';
import 'package:epic_hire/theme/themes/base.dart';
import 'package:flutter/material.dart';
import 'package:universal_platform/universal_platform.dart';

bool useAmoled = true;

ThemeData getDarkTheme(BuildContext context) {
  return ThemeData.from(
    colorScheme: ColorScheme.dark(primary: AppColorsAmoled.primary),
  ).copyWith(
    textTheme: getBaseTextTheme(context),
    extensions: [
      (UniversalPlatform.isMobile && useAmoled)
          ? const EpicHireTheme(
              foreground: AppColorsAmoled.foreground,
              background: AppColorsAmoled.background,
              dirtyWhite: AppColorsAmoled.dirtyWhite,
              white: AppColorsAmoled.white,
              gray: AppColorsAmoled.gray,
              darkGray: AppColorsAmoled.darkGray,
              primary: AppColorsAmoled.primary,
              red: AppColorsAmoled.red,
              green: AppColorsAmoled.green,
              yellow: AppColorsAmoled.yellow,
            )
          : const EpicHireTheme(
              foreground: AppColorsDark.foreground,
              background: AppColorsDark.background,
              dirtyWhite: AppColorsDark.dirtyWhite,
              white: AppColorsDark.white,
              gray: AppColorsDark.gray,
              darkGray: AppColorsDark.darkGray,
              primary: AppColorsDark.primary,
              red: AppColorsDark.red,
              green: AppColorsDark.green,
              yellow: AppColorsDark.yellow,
            ),
    ],
  );
}
