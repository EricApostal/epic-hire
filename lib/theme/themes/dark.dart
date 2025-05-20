import 'package:epic_hire/theme/color_theme.dart';
import 'package:epic_hire/theme/theme.dart';
import 'package:epic_hire/theme/themes/base.dart';
import 'package:flutter/material.dart';
import 'package:universal_platform/universal_platform.dart';

final darkTheme = ThemeData.dark().copyWith(
  textTheme: baseTextTheme,
  extensions: [
    UniversalPlatform.isMobile
        ? const EpicHireTheme(
            foreground: AppColorsAmoled.foreground,
            background: AppColorsAmoled.background,
            dirtyWhite: AppColorsAmoled.dirtyWhite,
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
            gray: AppColorsDark.gray,
            darkGray: AppColorsDark.darkGray,
            primary: AppColorsDark.primary,
            red: AppColorsDark.red,
            green: AppColorsDark.green,
            yellow: AppColorsDark.yellow,
          ),
  ],
);
