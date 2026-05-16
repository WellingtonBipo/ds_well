import 'dart:ui';

import 'package:ds_well/ds_well.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widget_previews.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return WidgetsApp(
      color: Color.fromARGB(0, 0, 0, 0),
      builder: (context, _) => const _Screen(),
    );
  }
}

class _Screen extends StatefulWidget {
  const _Screen();

  @override
  State<_Screen> createState() => _ScreenState();
}

class _ScreenState extends State<_Screen> {
  var _sysBrightness = PlatformDispatcher.instance.platformBrightness;

  @override
  Widget build(BuildContext context) {
    return MediaQuery(
      data: MediaQuery.of(context).copyWith(platformBrightness: _sysBrightness),
      child: Column(
        mainAxisSize: .min,
        mainAxisAlignment: .center,
        children: [
          ...DsThemePreviewMulti().previews.map(_Wrapper.new),
          Builder(
            builder: (context) {
              return Column(
                spacing: 20,
                mainAxisAlignment: .center,
                children: [
                  ElevatedButton(
                    onPressed: () => setState(
                      () => _sysBrightness = switch (_sysBrightness) {
                        .light => .dark,
                        .dark => .light,
                      },
                    ),
                    child: Text('Change System Appearance ($_sysBrightness)'),
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}

class _Wrapper extends StatelessWidget {
  const _Wrapper(this.preview);

  final Preview preview;

  @override
  Widget build(BuildContext context) {
    final prev = preview.transform().toBuilder();
    return Column(
      crossAxisAlignment: .start,
      children: [
        Text(prev.name ?? 'Default'),
        SizedBox(height: 5),
        prev.wrapper!.call(dsThemePreview()(context)),
        SizedBox(height: 20),
      ],
    );
  }
}
