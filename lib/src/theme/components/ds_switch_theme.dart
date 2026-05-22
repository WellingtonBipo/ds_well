import 'package:ds_well/src/utils/color_extension.dart';
import 'package:flutter/widgets.dart';

class const DsSwitchTheme({final Color? color});

class DsSwitchThemeEffective({required final Color color}) {
  //
  static DsSwitchThemeEffective defaults(
    ({Color brand1, Color? brand2, Brightness brightness}) configs,
  ) => switch (configs.brightness) {
    .light => .new(color: (configs.brand2 ?? configs.brand1)),
    .dark => .new(color: (configs.brand2 ?? configs.brand1).changeTune(1.2)),
  };

  DsSwitchThemeEffective mergeWith(DsSwitchTheme? other) =>
      DsSwitchThemeEffective(
        color: other?.color ?? color,
      );
}
