import 'package:flutter/material.dart';

@immutable
class EpicHireTheme extends ThemeExtension<EpicHireTheme> {
  static EpicHireTheme of(BuildContext context) =>
      Theme.of(context).extension<EpicHireTheme>()!;

  const EpicHireTheme({
    required this.foreground,
    required this.background,
    required this.dirtyWhite,
    required this.white,
    required this.gray,
    required this.darkGray,
    required this.lightGray,
    required this.primary,
    required this.red,
    required this.purple,
    required this.blue,
    required this.green,
    required this.yellow,
  });

  final Color foreground;
  final Color background;
  final Color dirtyWhite;
  final Color white;
  final Color gray;
  final Color darkGray;
  final Color lightGray;
  final Color primary;
  final Color red;
  final Color green;
  final Color purple;
  final Color blue;
  final Color yellow;

  @override
  ThemeExtension<EpicHireTheme> copyWith({
    Color? foreground,
    Color? background,
    Color? dirtyWhite,
    Color? white,
    Color? gray,
    Color? darkGray,
    Color? lightGray,
    Color? primary,
    Color? red,
    Color? green,
    Color? yellow,
    Color? purple,
    Color? blue,
  }) {
    return EpicHireTheme(
      foreground: foreground ?? this.foreground,
      background: background ?? this.background,
      dirtyWhite: dirtyWhite ?? this.dirtyWhite,
      white: white ?? this.white,
      gray: gray ?? this.gray,
      darkGray: darkGray ?? this.darkGray,
      lightGray: lightGray ?? this.lightGray,
      primary: primary ?? this.primary,
      red: red ?? this.red,
      green: green ?? this.green,
      yellow: yellow ?? this.yellow,
      blue: blue ?? this.blue,
      purple: purple ?? this.purple,
    );
  }

  @override
  ThemeExtension<EpicHireTheme> lerp(
    covariant ThemeExtension<EpicHireTheme>? other,
    double t,
  ) {
    if (other is! EpicHireTheme) {
      return this;
    }

    return EpicHireTheme(
      foreground: Color.lerp(foreground, other.foreground, t)!,
      background: Color.lerp(background, other.background, t)!,
      dirtyWhite: Color.lerp(dirtyWhite, other.dirtyWhite, t)!,
      white: Color.lerp(white, other.white, t)!,
      gray: Color.lerp(gray, other.gray, t)!,
      darkGray: Color.lerp(darkGray, other.darkGray, t)!,
      lightGray: Color.lerp(lightGray, other.lightGray, t)!,
      primary: Color.lerp(primary, other.primary, t)!,
      red: Color.lerp(red, other.red, t)!,
      green: Color.lerp(green, other.green, t)!,
      yellow: Color.lerp(yellow, other.yellow, t)!,
      purple: Color.lerp(purple, other.purple, t)!,
      blue: Color.lerp(blue, other.blue, t)!,
    );
  }
}
