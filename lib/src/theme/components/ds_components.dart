import 'dart:ui';

import 'package:ds_well/src/theme/components/ds_text_theme.dart';

class DsThemeComponents {
  const DsThemeComponents({
    this.text = const DsTextTheme(),
  });

  final DsTextTheme text;
}

class DsThemeComponentsEffective extends DsThemeComponents {
  DsThemeComponentsEffective({
    DsTextThemeEffective? text,
  }) : super(
         text: text ?? DsTextThemeEffective(),
       );

  @override
  DsTextThemeEffective get text => super.text as DsTextThemeEffective;

  static final defaults = {
    for (final b in Brightness.values)
      b: DsThemeComponentsEffective(
        text: DsTextThemeEffective.defaults[b]!,
      ),
  };

  DsThemeComponentsEffective mergeWith(
    Brightness brightness,
    DsThemeComponents? components,
  ) => DsThemeComponentsEffective(
    text: text.mergeWith(brightness, components?.text),
  );
}
