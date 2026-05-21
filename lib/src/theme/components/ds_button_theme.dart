import 'package:ds_well/src/utils/color_extension.dart';
import 'package:flutter/widgets.dart';

class DsButtonTheme {
  const DsButtonTheme({
    this.text,
    this.textDisabled,
    this.textDanger,
    this.textDangerDisabled,
    this.filledText,
    this.filled,
    this.filledDisabled,
    this.filledDanger,
    this.filledDangerDisabled,
    this.outlined,
    this.outlinedDisabled,
    this.outlinedDanger,
    this.outlinedDangerDisabled,
    this.loading,
  });

  final Color? text;
  final Color? textDisabled;
  final Color? textDanger;
  final Color? textDangerDisabled;

  final Color? filledText;
  final Color? filled;
  final Color? filledDisabled;
  final Color? filledDanger;
  final Color? filledDangerDisabled;

  final Color? outlined;
  final Color? outlinedDisabled;
  final Color? outlinedDanger;
  final Color? outlinedDangerDisabled;

  final Color? loading;
}

class DsButtonThemeEffective {
  DsButtonThemeEffective({
    required this.text,
    required this.textDisabled,
    required this.textDanger,
    required this.textDangerDisabled,
    required this.filledText,
    required this.filled,
    required this.filledDisabled,
    required this.filledDanger,
    required this.filledDangerDisabled,
    required this.outlined,
    required this.outlinedDisabled,
    required this.outlinedDanger,
    required this.outlinedDangerDisabled,
    required this.loading,
  }) : super();

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

  final Color text;
  final Color textDisabled;
  final Color textDanger;
  final Color textDangerDisabled;

  final Color filledText;
  final Color filled;
  final Color filledDisabled;
  final Color filledDanger;
  final Color filledDangerDisabled;

  final Color outlined;
  final Color outlinedDisabled;
  final Color outlinedDanger;
  final Color outlinedDangerDisabled;

  final Color loading;

  DsButtonThemeEffective mergeWith(
    Brightness brightness,
    DsButtonTheme? other,
  ) => DsButtonThemeEffective(
    text: other?.text ?? text,
    textDisabled: other?.textDisabled ?? textDisabled,
    textDanger: other?.textDanger ?? textDanger,
    textDangerDisabled: other?.textDangerDisabled ?? textDangerDisabled,
    filledText: other?.filledText ?? filledText,
    filled: other?.filled ?? filled,
    filledDisabled: other?.filledDisabled ?? filledDisabled,
    filledDanger: other?.filledDanger ?? filledDanger,
    filledDangerDisabled: other?.filledDangerDisabled ?? filledDangerDisabled,
    outlined: other?.outlined ?? outlined,
    outlinedDisabled: other?.outlinedDisabled ?? outlinedDisabled,
    outlinedDanger: other?.outlinedDanger ?? outlinedDanger,
    outlinedDangerDisabled:
        other?.outlinedDangerDisabled ?? outlinedDangerDisabled,
    loading: other?.loading ?? loading,
  );
}
