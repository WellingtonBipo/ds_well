import 'package:ds_well/src/components/text/ds_text.dart';
import 'package:ds_well/src/theme/ds_theme_preview.dart';
import 'package:flutter/widgets.dart';
import 'package:utils_well/utils_well.dart';

/// ### iOS Typography Sizes (SF Pro)
///
/// #### Headings
/// | Category..... | Name........ | Size.... | Usage             |
/// |---------------|--------------|----------|-------------------|
/// | Headings      | Large Title  | 34 pt    | Main title        |
/// | Headings      | Title 1      | 28 pt    | Important title   |
/// | Headings      | Title 2      | 22 pt    | Main sections     |
/// | Headings      | Title 3      | 20 pt    | Subtitles         |
/// | Body          | Headline     | 17 pt    | List titles       |
/// | Body          | Body         | 17 pt    | Main text         |
/// | Body          | Callout      | 16 pt    | Secondary text    |
/// | Body          | SubHeadline  | 15 pt    | Complements       |
/// | Helper        | Footnote     | 13 pt    | Aux. information  |
/// | Helper        | Caption 1    | 12 pt    | Labels / notes    |
/// | Helper        | Caption 2    | 11 pt    | Very small text   |
final class DsTextStyle {
  const DsTextStyle(this.fontSize, this.fontWeight);

  static const title1 = DsTextStyle(24, .w600);
  static const title2 = DsTextStyle(20, .w600);
  static const title3 = DsTextStyle(18, .w600);

  static const headline = DsTextStyle(16, .w500);
  static const body = DsTextStyle(15, .w500);
  static const callout = DsTextStyle(14, .w400);
  static const subHeadline = DsTextStyle(13, .w400);

  static const footnote = DsTextStyle(12, .w400);
  static const caption1 = DsTextStyle(11, .w400);
  static const caption2 = DsTextStyle(10, .w400);

  final double fontSize;
  final FontWeight fontWeight;

  Size textWidgetSize(
    BuildContext context, {
    String text = '',
    double maxWidth = double.infinity,
    TextScaler? textScaler,
  }) => _toTextStyle().textWidgetSize(
    context,
    text: text,
    maxWidth: maxWidth,
    textScaler: textScaler,
  );

  List<LineMetrics> textWidgetLineMetrics(
    BuildContext context, {
    String text = '',
    double maxWidth = double.infinity,
    TextScaler? textScaler,
  }) => _toTextStyle().textWidgetLineMetrics(
    context,
    text: text,
    maxWidth: maxWidth,
    textScaler: textScaler,
  );

  TextStyle toTextStyle() => TextStyle(
    fontSize: fontSize,
    fontWeight: fontWeight,
  );

  TextStyle _toTextStyle() => toTextStyle().copyWith(decoration: .none);
}

@DsThemePreview(group: 'DsTextStyle')
WidgetBuilder preview() =>
    (context) => Column(
      children: [
        DsText('title1', style: .title1),
        DsText('title2', style: .title2),
        DsText('title3', style: .title3),
        DsText('headline', style: .headline),
        DsText('body', style: .body),
        DsText('callout', style: .callout),
        DsText('subHeadline', style: .subHeadline),
        DsText('footnote', style: .footnote),
        DsText('caption1', style: .caption1),
        DsText('caption2', style: .caption2),
      ],
    );
