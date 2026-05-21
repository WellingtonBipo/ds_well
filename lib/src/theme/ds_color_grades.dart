import 'package:ds_well/src/theme/ds_theme.dart';
import 'package:flutter/widgets.dart';

class const ColorGrades({
  final DsThemeColors? _primary,
  final DsThemeColors? _secondary,
  final DsThemeColors? _tertiary,
});

class const ColorGradesEffective({
  required final Color primary,
  required final Color secondary,
  required final Color tertiary,
}) {
  factory merge(
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
