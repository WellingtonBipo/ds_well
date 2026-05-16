import 'package:ds_well/src/theme/ds_theme.dart';
import 'package:flutter/widgets.dart';

class ColorGrades {
  const ColorGrades({
    DsThemeColors? primary,
    DsThemeColors? secondary,
    DsThemeColors? tertiary,
  }) : _primary = primary,
       _secondary = secondary,
       _tertiary = tertiary;

  final DsThemeColors? _primary;
  final DsThemeColors? _secondary;
  final DsThemeColors? _tertiary;
}

class ColorGradesEffective extends ColorGrades {
  const ColorGradesEffective({
    required this.primary,
    required this.secondary,
    required this.tertiary,
  });

  final Color primary;
  final Color secondary;
  final Color tertiary;

  factory ColorGradesEffective.merge(
    Brightness brightness,
    ColorGrades? a,
    ColorGrades? b,
    Color defaultPrimary,
    Color defaultSecondary,
    Color defaultTertiary,
  ) {
    Color? color(ColorGrade grade) => switch (grade) {
      .primary => (a?._primary ?? b?._primary) / brightness,
      .secondary => (a?._secondary ?? b?._secondary) / brightness,
      .tertiary => (a?._tertiary ?? b?._tertiary) / brightness,
    };
    return ColorGradesEffective(
      primary: color(.primary) ?? defaultPrimary,
      secondary: color(.secondary) ?? defaultSecondary,
      tertiary: color(.tertiary) ?? defaultTertiary,
    );
  }

  ColorGradesEffective mergeWith(
    Brightness brightness,
    ColorGrades? other,
  ) {
    return ColorGradesEffective(
      primary: other?._primary / brightness ?? primary,
      secondary: other?._secondary / brightness ?? secondary,
      tertiary: other?._tertiary / brightness ?? tertiary,
    );
  }

  Color byGrade(ColorGrade grade) => switch (grade) {
    .primary => primary,
    .secondary => secondary,
    .tertiary => tertiary,
  };
}

enum ColorGrade { primary, secondary, tertiary }
