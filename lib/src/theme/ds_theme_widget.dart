part of 'ds_theme.dart';

class const DsThemeWidget({
  final DsTheme? theme,
  final DsThemeMode? mode,
  final Widget Function(BuildContext context)? builder,
  final Widget? child,
  super.key,
}) extends StatefulWidget {
  @override
  State<DsThemeWidget> createState() => DsThemeWidgetState();
}

class DsThemeWidgetState extends State<DsThemeWidget> {
  late ValueNotifier<(Brightness, DsThemeMode)> _notifier;

  DsThemeWidgetState? _parentState;
  DsThemeEffective? get _parentTheme => _parentState?._theme;

  late DsThemeEffective _theme;

  @override
  void initState() {
    super.initState();
    _parentState = context.findAncestorStateOfType<DsThemeWidgetState>();
    _notifier =
        _parentState?._notifier ??
        ValueNotifier((
          PlatformDispatcher.instance.platformBrightness,
          widget.mode ?? DsThemeMode.system,
        ));
    _notifier.addListener(_setTheme);
    _setTheme();
    if (_parentTheme == null) _setFromCache();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_parentState != null) return;
    final brightness = MediaQuery.platformBrightnessOf(context);
    addPostFrameCallback(() {
      _setAppearance(platformBrightness: brightness);
    });
  }

  @override
  void dispose() {
    _parentTheme == null
        ? _notifier.dispose()
        : _notifier.removeListener(_setTheme);
    super.dispose();
  }

  Future<void> _setFromCache() async {
    final storage = await SharedPreferences.getInstance();
    final modeText = storage.getString('ds_well_appearance_mode');
    final mode = DsThemeMode.values.getByNameOrNull(modeText);
    if (mode != null) _setAppearance(mode: mode);
  }

  void _setTheme() {
    final mode = _parentState == null
        ? _notifier.value.$2
        : widget.mode ?? _parentState?.widget.mode ?? _notifier.value.$2;
    final brightness = _notifier.value._brightnessForMode(mode);
    _theme = DsThemeEffective(
      isSystemMode: mode.isSystem,
      brightness: brightness,
    ).mergeWith(widget.theme);
  }

  void _setAppearance({
    Brightness? platformBrightness,
    DsThemeMode? mode,
  }) {
    final b = platformBrightness ?? _notifier.value.$1;
    final m = mode ?? _notifier.value.$2;
    if (b == _notifier.value.$1 && m == _notifier.value.$2) return;
    _notifier.value = (b, m);
    SharedPreferences.getInstance().then(
      (s) => s.setString('ds_well_appearance_mode', m.name),
    );
  }

  @override
  Widget build(BuildContext context) {
    final finalChild = widget.builder != null
        ? Builder(builder: widget.builder!)
        : widget.child ?? const SizedBox();

    if (_parentTheme != null) return finalChild;
    return _InheritedNotifier(
      notifier: _notifier,
      child: finalChild,
    );
  }
}

class const _InheritedNotifier({
  required super.notifier,
  required super.child,
}) extends InheritedNotifier<ValueNotifier<(Brightness, DsThemeMode)>> {
  @override
  ValueNotifier<(Brightness, DsThemeMode)> get notifier => super.notifier!;
}

extension on (Brightness, DsThemeMode) {
  Brightness _brightnessForMode(DsThemeMode mode) {
    return switch (mode) {
      DsThemeMode.system => $1,
      DsThemeMode.light => Brightness.light,
      DsThemeMode.dark => Brightness.dark,
    };
  }
}
