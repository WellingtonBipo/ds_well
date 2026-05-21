import 'dart:ui';

import 'package:ds_well/src/theme/components/ds_text_theme.dart';
import 'package:ds_well/src/theme/components/ds_button_theme.dart';

class const DsThemeComponents({
  final DsTextTheme text = const DsTextTheme(),
  final DsButtonTheme button = const DsButtonTheme(),
});

class const DsThemeComponentsEffective({
  required final DsTextThemeEffective text,
  required final DsButtonThemeEffective button,
}) {
  static DsThemeComponentsEffective defaults(
    ({Color brand1, Color? brand2, Brightness brightness}) configs,
  ) => {
    for (final b in Brightness.values)
      b: DsThemeComponentsEffective(
        text: DsTextThemeEffective.defaults[b]!,
        button: DsButtonThemeEffective.defaults(configs),
      ),
  }[configs.brightness]!;

  DsThemeComponentsEffective mergeWith(
    Brightness brightness,
    DsThemeComponents? components,
  ) => DsThemeComponentsEffective(
    text: text.mergeWith(brightness, components?.text),
    button: button.mergeWith(brightness, components?.button),
  );
}
