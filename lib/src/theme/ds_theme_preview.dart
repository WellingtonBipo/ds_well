// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:ds_well/ds_well.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widget_previews.dart';

final class DsThemePreview extends Preview {
  const DsThemePreview({
    super.group,
    super.name,
    this.mode,
  }) : super();

  final DsThemeMode? mode;

  static const minWidth = 195.0;

  @override
  String? get name {
    if (mode == null) return super.name;
    final n = super.name == null ? '' : '${super.name!} (';
    return '$n(Mode: ${mode!.name}${n.isEmpty ? '' : ')'})';
  }

  @override
  Preview transform() {
    final t = super.transform();
    final b = t.toBuilder();
    b.wrapper = _wrapper;
    // b.wrapper = (c) => Text('data');
    return b.build();
  }

  Widget _wrapper(Widget child) => DsThemeWidget(
    mode: mode,
    builder: (context) => ConstrainedBox(
      constraints: BoxConstraints(minWidth: minWidth),
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: DsTheme.of(context).background.primary,
          borderRadius: .circular(8),
        ),
        child: Align(
          widthFactor: 1,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: child,
          ),
        ),
      ),
    ),
  );
}

@DsThemePreviewMulti()
WidgetBuilder dsThemePreview() =>
    (context) => Column(
      children: [
        DsThemeWidget(
          child: DsText('theme'),
        ),
        DsThemeWidget(
          mode: .light,
          child: DsText('theme light'),
        ),
        DsThemeWidget(
          mode: .dark,
          child: DsText('theme dark'),
        ),
        DsThemeWidget(
          theme: _changeTextTheme(darkRed: true),
          child: DsText('always primary red'),
        ),
        DsThemeWidget(
          theme: _changeTextTheme(),
          child: DsText('primary light red'),
        ),
      ],
    );

DsTheme _changeTextTheme({bool darkRed = false}) {
  final red = Color.fromARGB(255, 244, 67, 54);
  return DsTheme(
    components: DsThemeComponents(
      text: DsTextTheme(
        grades: ColorGrades(
          primary: DsThemeColors(
            light: red,
            dark: darkRed ? red : null,
          ),
        ),
      ),
    ),
  );
}

final class DsThemePreviewMulti extends MultiPreview {
  const DsThemePreviewMulti() : super();

  @override
  List<Preview> get previews => [
    DsThemePreview(group: 'DsThemePreview'),
    DsThemePreview(group: 'DsThemePreview', mode: .system),
    DsThemePreview(group: 'DsThemePreview', mode: .light),
  ];
}
