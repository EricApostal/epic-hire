import 'package:epic_hire/theme/color_theme.dart';
import 'package:epic_hire/theme/text_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

ColorTheme darkTheme = ColorTheme(
  background: AppColorsDark.background,
  foreground: AppColorsDark.foreground,
  primary: AppColorsDark.primary,
  secondary: AppColorsDark.secondary,
  tertiary: AppColorsDark.tertiary,
  dirtywhite: AppColorsDark.dirtyWhite,
  red: Colors.red,
  green: Colors.green,
  blue: Colors.blue,
  yellow: Colors.yellow,
);

class CustomThemeData {
  final textTheme = CustomTextTheme();
  late final ColorTheme colorTheme;

  CustomThemeData({required bool isDarkTheme}) {
    colorTheme = isDarkTheme ? darkTheme : darkTheme;
  }
}

final darkThemeProvider = Provider((ref) => _darkTheme);
// final lightThemeProvider = Provider((ref) => _theme);

final _customTheme = CustomThemeData(isDarkTheme: false);

// Dark theme
final _customDarkTheme = CustomThemeData(isDarkTheme: true);
final _darkTheme = ThemeData(
  brightness: Brightness.dark,
  dialogTheme: DialogThemeData(
    shape: RoundedRectangleBorder(
      side: const BorderSide(color: Colors.transparent),
      borderRadius: BorderRadius.circular(4.0),
    ),
    backgroundColor: AppColorsDark.background,
    titleTextStyle: const TextStyle(
      color: AppColorsDark.dirtyWhite,
      fontSize: 16,
    ),
    contentTextStyle: const TextStyle(
      color: AppColorsDark.dirtyWhite,
      fontSize: 16,
    ),
  ),
  floatingActionButtonTheme: const FloatingActionButtonThemeData(
    backgroundColor: AppColorsDark.primary,
    foregroundColor: Colors.white,
  ),
  scaffoldBackgroundColor: AppColorsDark.background,
  iconTheme: const IconThemeData(color: AppColorsDark.dirtyWhite),
  progressIndicatorTheme: const ProgressIndicatorThemeData(
    color: AppColorsDark.primary,
  ),
  dividerTheme: const DividerThemeData(
    color: AppColorsDark.dirtyWhite,
    thickness: 0.1,
  ),
  textSelectionTheme: TextSelectionThemeData(
    cursorColor: AppColorsDark.dirtyWhite,
    selectionColor: AppColorsDark.dirtyWhite.withOpacity(0.4),
    selectionHandleColor: AppColorsDark.dirtyWhite,
  ),
  inputDecorationTheme: InputDecorationTheme(
    focusedBorder: UnderlineInputBorder(
      borderSide: BorderSide(color: Colors.grey),
    ),
  ),
);

extension CustomTheme on ThemeData {
  CustomThemeData get custom =>
      brightness == Brightness.dark ? _customDarkTheme : _customTheme;

  AssetImage themedImage(String name) {
    final path =
        brightness == Brightness.dark ? 'assets/images/dark' : 'assets/images';
    return AssetImage('$path/$name');
  }
}
