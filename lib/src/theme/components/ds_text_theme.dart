import 'package:ds_well/src/components/text/ds_text_style.dart';
import 'package:ds_well/src/theme/ds_color_grades.dart';
import 'package:flutter/widgets.dart';

class DsTextTheme {
  const DsTextTheme({this.style, this.grades});

  final DsTextStyle? style;
  final ColorGrades? grades;
}

class DsTextThemeEffective extends DsTextTheme {
  DsTextThemeEffective({
    DsTextStyle super.style = DsTextStyle.body,
    ColorGradesEffective? grades,
  }) : super(
         grades: grades ?? defaults[Brightness.light]!.grades,
       );

  @override
  DsTextStyle get style => super.style!;

  @override
  ColorGradesEffective get grades => super.grades as ColorGradesEffective;

  static final defaults = {
    Brightness.light: DsTextThemeEffective(
      style: DsTextStyle.body,
      grades: const ColorGradesEffective(
        primary: Color.fromARGB(255, 33, 33, 33),
        secondary: Color.fromARGB(255, 67, 67, 67),
        tertiary: Color.fromARGB(255, 86, 86, 86),
      ),
    ),
    Brightness.dark: DsTextThemeEffective(
      style: DsTextStyle.body,
      grades: const ColorGradesEffective(
        primary: Color.fromARGB(255, 236, 236, 236),
        secondary: Color.fromARGB(255, 214, 214, 214),
        tertiary: Color.fromARGB(255, 196, 196, 196),
      ),
    ),
  };

  DsTextThemeEffective mergeWith(Brightness brightness, DsTextTheme? other) =>
      DsTextThemeEffective(
        style: other?.style ?? style,
        grades: grades.mergeWith(brightness, other?.grades),
      );
}
