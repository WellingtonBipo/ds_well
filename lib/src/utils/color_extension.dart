import 'package:flutter/widgets.dart';

extension ColorExtension on Color {
  Color changeTune(
    double ratio, {
    double r = 1,
    double g = 1,
    double b = 1,
  }) => Color.fromRGBO(
    (this.r * 255 * ratio * r).toInt().clamp(0, 255),
    (this.g * 255 * ratio * g).toInt().clamp(0, 255),
    (this.b * 255 * ratio * b).toInt().clamp(0, 255),
    1,
  );
}
