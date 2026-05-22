import 'package:ds_well/src/utils/color_extension.dart';
import 'package:flutter/widgets.dart';

class const DsButtonTheme({
  final Color? text,
  final Color? textDisabled,
  final Color? textDanger,
  final Color? textDangerDisabled,
  final Color? filledText,
  final Color? filled,
  final Color? filledDisabled,
  final Color? filledDanger,
  final Color? filledDangerDisabled,
  final Color? outlined,
  final Color? outlinedDisabled,
  final Color? outlinedDanger,
  final Color? outlinedDangerDisabled,
  final Color? loading,
});

class const DsButtonThemeEffective({
  required final Color text,
  required final Color textDisabled,
  required final Color textDanger,
  required final Color textDangerDisabled,
  required final Color filledText,
  required final Color filled,
  required final Color filledDisabled,
  required final Color filledDanger,
  required final Color filledDangerDisabled,
  required final Color outlined,
  required final Color outlinedDisabled,
  required final Color outlinedDanger,
  required final Color outlinedDangerDisabled,
  required final Color loading,
}) {
  static DsButtonThemeEffective defaults(
    ({Color brand1, Color? brand2, Brightness brightness}) configs,
  ) {
    final brand = configs.brand2 ?? configs.brand1;
    var text = const Color.fromARGB(255, 33, 33, 33);
    var textDanger = const Color.fromARGB(255, 211, 29, 29);
    var textDangerDisable = textDanger.withAlpha(150);

    var filledText = const Color.fromARGB(255, 255, 255, 255);
    var filled = brand;
    var filledDanger = const Color.fromARGB(255, 211, 29, 29);
    var filledDangerDisable = filledDanger.withAlpha(150);

    var outlined = const Color.fromARGB(255, 33, 33, 33);

    if (configs.brightness == Brightness.dark) {
      text = const Color.fromARGB(255, 236, 236, 236);
      filled = brand.changeTune(1.2);
      outlined = const Color.fromARGB(255, 236, 236, 236);
    }

    var textDisable = text.withAlpha(150);

    var filledDisable = filled.withAlpha(150);

    var outlinedDisable = outlined.withAlpha(150);
    var outlinedDanger = textDanger;
    var outlinedDangerDisable = outlinedDanger.withAlpha(150);

    return DsButtonThemeEffective(
      text: text,
      textDisabled: textDisable,
      textDanger: textDanger,
      textDangerDisabled: textDangerDisable,
      filledText: filledText,
      filled: filled,
      filledDisabled: filledDisable,
      filledDanger: filledDanger,
      filledDangerDisabled: filledDangerDisable,
      outlined: outlined,
      outlinedDisabled: outlinedDisable,
      outlinedDanger: outlinedDanger,
      outlinedDangerDisabled: outlinedDangerDisable,
      loading: brand,
    );
  }

  DsButtonThemeEffective mergeWith(DsButtonTheme? other) =>
      DsButtonThemeEffective(
        text: other?.text ?? text,
        textDisabled: other?.textDisabled ?? textDisabled,
        textDanger: other?.textDanger ?? textDanger,
        textDangerDisabled: other?.textDangerDisabled ?? textDangerDisabled,
        filledText: other?.filledText ?? filledText,
        filled: other?.filled ?? filled,
        filledDisabled: other?.filledDisabled ?? filledDisabled,
        filledDanger: other?.filledDanger ?? filledDanger,
        filledDangerDisabled:
            other?.filledDangerDisabled ?? filledDangerDisabled,
        outlined: other?.outlined ?? outlined,
        outlinedDisabled: other?.outlinedDisabled ?? outlinedDisabled,
        outlinedDanger: other?.outlinedDanger ?? outlinedDanger,
        outlinedDangerDisabled:
            other?.outlinedDangerDisabled ?? outlinedDangerDisabled,
        loading: other?.loading ?? loading,
      );
}
