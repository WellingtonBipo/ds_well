import 'package:ds_well/src/components/shimmer/ds_shimmer.dart';
import 'package:ds_well/src/components/text/ds_text_style.dart';
import 'package:ds_well/src/theme/ds_color_grades.dart';
import 'package:ds_well/src/theme/ds_theme.dart';
import 'package:ds_well/src/theme/ds_theme_preview.dart';
import 'package:flutter/widgets.dart';
import 'package:utils_well/utils_well.dart';

class DsText extends StatelessWidget {
  const DsText(
    String this.data, {
    this.softWrap,
    TextOverflow? overflow,
    this.textAlign,
    this.color,
    this.colorTheme,
    this.maxLines,
    this.style,
    this.state,
    super.key,
  }) : overflow =
           overflow ?? ((softWrap ?? false) ? TextOverflow.ellipsis : null),
       childrenData = null;

  const DsText.rich({
    required List<DsText> children,
    this.softWrap,
    TextOverflow? overflow,
    this.textAlign,
    this.color,
    this.colorTheme,
    this.maxLines,
    this.style,
    this.state,
    super.key,
  }) : overflow =
           overflow ?? ((softWrap ?? false) ? TextOverflow.ellipsis : null),
       childrenData = children,
       data = null;

  final String? data;
  final List<DsText>? childrenData;
  final Color? color;
  final ColorGrade? colorTheme;
  final DsTextStyle? style;
  final bool? softWrap;
  final TextOverflow? overflow;
  final TextAlign? textAlign;
  final int? maxLines;
  final DsTextState? state;

  @override
  Widget build(BuildContext context) {
    Widget? child;
    final data = this.data;
    if (data != null) {
      child = Text(
        data,
        softWrap: softWrap,
        overflow: overflow,
        textAlign: textAlign,
        style: _toTextStyle(context),
        maxLines: maxLines,
      );
    }

    if (child == null) {
      final children = [
        for (final e in childrenData ?? <DsText>[])
          TextSpan(
            text: e.data,
            style: _toTextStyle(context, e.style, e.color, e.colorTheme),
          ),
      ];
      child = Text.rich(
        TextSpan(children: children),
        softWrap: softWrap,
        overflow: overflow,
        textAlign: textAlign,
        maxLines: maxLines,
        style: _toTextStyle(context),
      );
    }
    final shimmerEnabled = switch (state) {
      null || DsTextState.normal => false,
      DsTextState.loading => true,
    };
    return DsShimmer(enabled: shimmerEnabled, child: child);
  }

  TextStyle _toTextStyle(
    BuildContext context, [
    DsTextStyle? otherStyle,
    Color? otherColor,
    ColorGrade? otherColorTheme,
  ]) {
    final theme = DsTheme.of(context).components.text;
    final s = otherStyle ?? style ?? theme.style;
    return TextStyle(
      fontSize: s.fontSize,
      fontWeight: s.fontWeight,
      color:
          (otherColor ??
              otherColorTheme?.let((e) => theme.grades.byGrade(e))) ??
          (color ?? theme.grades.byGrade(colorTheme ?? .primary)),
    );
  }
}

enum DsTextState { normal, loading }

@DsThemePreview(group: 'DsText')
WidgetBuilder dsTextPreview() =>
    (context) => DsText('Text', style: .title1);
