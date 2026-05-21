// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:ds_well/src/theme/ds_color_grades.dart';
import 'package:ds_well/src/theme/components/ds_components.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:utils_well/utils_well.dart';

part 'ds_theme_widget.dart';

class DsTheme {
  const DsTheme({
    Color? brand1,
    this.brand2,
    this.background,
    this.components,
  }) : brand1 = brand1 ?? brand1K;

  final Color brand1;
  final Color? brand2;

  final ColorGrades? background;
  final DsThemeComponents? components;

  static const brand1K = Color.fromARGB(255, 0, 87, 157);

  static void setAppearance({
    required BuildContext context,
    Brightness? platformBrightness,
    DsThemeMode? mode,
  }) {
    context.findRootAncestorStateOfType<DsThemeWidgetState>()?._setAppearance(
      platformBrightness: platformBrightness,
      mode: mode,
    );
  }

  static DsThemeEffective of(
    BuildContext context, {
    bool listen = true,
    bool root = false,
  }) {
    listen
        ? context.dependOnInheritedWidgetOfExactType<_InheritedNotifier>()
        : context.getInheritedWidgetOfExactType<_InheritedNotifier>();
    final themeWidget = root
        ? context.findRootAncestorStateOfType<DsThemeWidgetState>()
        : context.findAncestorStateOfType<DsThemeWidgetState>();
    return themeWidget?._theme ??
        DsThemeEffective(
          brightness:
              WidgetsBinding.instance.platformDispatcher.platformBrightness,
        );
  }
}

class DsThemeEffective {
  DsThemeEffective({
    this.brightness = .light,
    this.isSystemMode = false,
    this.brand1 = DsTheme.brand1K,
    this.brand2,
    ColorGradesEffective? background,
    DsThemeComponentsEffective? components,
  }) {
    final configs = (brightness: brightness, brand1: brand1, brand2: brand2);
    this.background = background ?? DsThemeEffective.backgroundK[brightness]!;
    this.components =
        components ?? DsThemeComponentsEffective.defaults(configs);
  }

  final Brightness brightness;
  final bool isSystemMode;

  final Color brand1;
  final Color? brand2;
  late final ColorGradesEffective background;
  late final DsThemeComponentsEffective components;

  static final backgroundK = {
    Brightness.light: ColorGradesEffective(
      primary: Color.fromARGB(255, 255, 255, 255),
      secondary: Color.fromARGB(255, 226, 226, 226),
      tertiary: Color.fromARGB(255, 215, 215, 215),
    ),
    Brightness.dark: ColorGradesEffective(
      primary: Color.fromARGB(255, 30, 30, 30),
      secondary: Color.fromARGB(255, 40, 40, 40),
      tertiary: Color.fromARGB(255, 55, 55, 55),
    ),
  };

  DsThemeEffective copyWith({
    bool? isSystemMode,
    Brightness? brightness,
    ColorGradesEffective? background,
    DsThemeComponentsEffective? components,
  }) {
    return DsThemeEffective(
      brightness: brightness ?? this.brightness,
      isSystemMode: isSystemMode ?? this.isSystemMode,
      background: background ?? this.background,
      components: components ?? this.components,
    );
  }

  DsThemeEffective mergeWith(DsTheme? other) => DsThemeEffective(
    isSystemMode: isSystemMode,
    brightness: brightness,
    background: background.mergeWith(brightness, other?.background),
    components: components.mergeWith(brightness, other?.components),
  );

  // static DsThemeEffective merge(
  //   Brightness brightness,
  //   bool isSystemMode,
  //   DsTheme? theme,
  //   DsTheme? theme2,
  // ) {
  //   return DsThemeEffective(
  //     brightness: brightness,
  //     isSystemMode: isSystemMode,
  //     background: kBackground[brightness]!
  //         .mergeWith(brightness, theme?.background)
  //         .mergeWith(brightness, theme2?.background),
  //     components: DsThemeComponentsEffective.defaults[brightness]!
  //         .mergeWith(brightness, theme?.components)
  //         .mergeWith(brightness, theme2?.components),
  //   );
  // }
}

class DsThemeColors {
  const DsThemeColors({
    this.light,
    this.dark,
  });

  const DsThemeColors.all(this.light) : dark = light;

  final Color? light;
  final Color? dark;
}

extension DsThemeColorsExt on DsThemeColors? {
  Color? byBrightness(Brightness brightness) => this / brightness;

  Color? operator /(Brightness brightness) => switch (brightness) {
    Brightness.light => this?.light,
    Brightness.dark => this?.dark,
  };
}

enum DsThemeMode {
  system,
  light,
  dark
  ;

  bool get isSystem => this == .system;
}

extension DsThemeModeExt on DsThemeMode? {
  bool get isSystem => this == .system;
}
