import 'package:ds_well/src/components/text/ds_text.dart';
import 'package:ds_well/src/components/text/ds_text_style.dart';
import 'package:ds_well/src/theme/ds_theme.dart';
import 'package:ds_well/src/theme/ds_theme_preview.dart';
import 'package:flutter/material.dart' show CircularProgressIndicator;
import 'package:flutter/widgets.dart';

class DsButton extends StatefulWidget {
  const DsButton({
    required this.text,
    required this.type,
    this.onTap,
    this.padding,
    this.leading,
    DsButtonState? state,
    this.isDanger,
    this.expand = true,
    super.key,
  }) : state = state ?? _kState;

  const DsButton.text({
    required this.text,
    this.onTap,
    this.padding,
    DsButtonState? state,
    this.isDanger,
    this.expand = true,
    super.key,
  }) : type = .text,
       leading = null,
       state = state ?? _kState;

  const DsButton.filled({
    required this.text,
    this.onTap,
    this.padding,
    this.leading,
    DsButtonState? state,
    this.isDanger,
    this.expand = true,
    super.key,
  }) : type = .filled,
       state = state ?? _kState;

  const DsButton.outlined({
    required this.text,
    this.onTap,
    this.padding,
    this.leading,
    DsButtonState? state,
    this.isDanger,
    this.expand = true,
    super.key,
  }) : type = .outlined,
       state = state ?? _kState;

  final String text;
  final EdgeInsets? padding;
  final VoidCallback? onTap;
  final DsButtonType type;
  final bool expand;
  final Widget? leading;
  final DsButtonState state;
  final bool? isDanger;

  static const _kState = DsButtonState.enabled;

  static DsButtonDecoration kDecoration(
    BuildContext context,
    DsButtonType type,
    DsButtonState state,
    bool? isDanger,
  ) {
    final danger = isDanger ?? false;
    final theme = DsTheme.of(context).components.button;
    Color textColor, backgroundColor, borderColor;
    var loadingColor = theme.loading;

    switch (type) {
      case .text:
        textColor = danger ? theme.textDanger : theme.text;
        if (danger) loadingColor = textColor;
        if (state == .disabled) {
          textColor = danger ? theme.textDangerDisabled : theme.textDisabled;
        }
        backgroundColor = Color.fromARGB(0, 0, 0, 0);
        borderColor = backgroundColor;
      case .filled:
        textColor = theme.filledText;
        loadingColor = textColor;
        backgroundColor = danger ? theme.filledDanger : theme.filled;
        if (state == .disabled) {
          backgroundColor = danger
              ? theme.filledDangerDisabled
              : theme.filledDisabled;
        }
        borderColor = backgroundColor;
      case .outlined:
        textColor = danger ? theme.outlinedDanger : theme.outlined;
        if (danger) loadingColor = textColor;
        if (state == .disabled) {
          textColor = danger
              ? theme.outlinedDangerDisabled
              : theme.outlinedDisabled;
        }
        backgroundColor = Color.fromARGB(0, 0, 0, 0);
        borderColor = textColor;
    }

    return DsButtonDecoration(
      textColor: textColor,
      loadingColor: loadingColor,
      boxDecoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(width: 1, color: borderColor),
      ),
    );
  }

  static const kPadding = EdgeInsets.symmetric(vertical: 12, horizontal: 10);

  @override
  State<DsButton> createState() => _DsButtonState();
}

class _DsButtonState extends State<DsButton>
    with SingleTickerProviderStateMixin {
  late final _onTapEffectController = AnimationController(
    vsync: this,
    duration: Duration(milliseconds: 100),
    reverseDuration: Duration(milliseconds: 100),
  );

  Animation<Color?> get _onTapEffect => _onTapEffectController.drive(
    ColorTween(
      begin: Color.fromARGB(0, 213, 213, 213),
      end: Color.fromARGB(90, 213, 213, 213),
    ),
  );

  @override
  void dispose() {
    _onTapEffectController.dispose();
    super.dispose();
  }

  bool get isEnabled => widget.state == .enabled;

  bool get isLoading => widget.state == .loading;

  @override
  Widget build(BuildContext context) {
    final decoration = DsButton.kDecoration(
      context,
      widget.type,
      widget.state,
      widget.isDanger,
    );
    final textSize = DsTextStyle.body.textWidgetSize(
      context,
      text: widget.text,
    );
    final textHeight = textSize.height;
    return GestureDetector(
      behavior: .opaque,
      onTapDown: (_) {
        if (!isEnabled) return;
        _onTapEffectController.forward();
      },
      onTapCancel: () {
        if (!isEnabled) return;
        _onTapEffectController.reverse();
      },
      onTapUp: (_) async {
        if (!isEnabled) return;
        widget.onTap?.call();
        if (_onTapEffectController.status == .forward) {
          await _onTapEffectController.forward();
        }
        return _onTapEffectController.reverse();
      },
      child: Stack(
        children: [
          Container(
            alignment: widget.expand ? .center : null,
            width: widget.expand ? double.infinity : null,
            padding: widget.padding ?? DsButton.kPadding,
            decoration: decoration.boxDecoration,
            child: Row(
              mainAxisSize: widget.expand ? .max : .min,
              mainAxisAlignment: .center,
              children: [
                if (widget.leading != null) ...[
                  SizedBox.square(dimension: textHeight, child: widget.leading),
                  const SizedBox(width: 10),
                ],
                _Content(widget, decoration, textHeight),
              ],
            ),
          ),
          ValueListenableBuilder(
            valueListenable: _onTapEffect,
            builder: (context, color, child) => Positioned.fill(
              child: DecoratedBox(
                decoration: decoration.boxDecoration.copyWith(
                  color: color,
                  border: .all(color: Color(0x00000000)),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _Content extends StatelessWidget {
  const _Content(this.widget, this.decoration, this.textHeight);

  final DsButton widget;
  final DsButtonDecoration decoration;
  final double textHeight;

  @override
  Widget build(BuildContext context) {
    final parent = context.findAncestorStateOfType<_DsButtonState>()!;
    final child = !parent.isLoading
        ? DsText(
            widget.text,
            color: decoration.textColor,
            style: .body,
          )
        : SizedBox.square(
            dimension: textHeight,
            child: CircularProgressIndicator(
              strokeWidth: 1.75,
              color: decoration.loadingColor,
            ),
          );
    return Flexible(child: child);
  }
}

enum DsButtonType { text, filled, outlined }

extension DsButtonTypeExt on DsButtonType? {
  bool get isText => this == .text;
  bool get isFilled => this == .filled;
  bool get isOutlined => this == .outlined;
}

enum DsButtonState { enabled, disabled, loading }

class DsButtonDecoration {
  DsButtonDecoration({
    required this.textColor,
    required this.loadingColor,
    required this.boxDecoration,
  });

  final Color textColor;
  final Color loadingColor;
  final BoxDecoration boxDecoration;
}

@DsThemePreview(group: 'DsButton')
Widget dsButtonPreview() => Column(
  spacing: 20,
  children: [
    _Group(.text),
    _Group(.outlined),
    _Group(.filled),
  ],
);

class _Group extends StatelessWidget {
  const _Group(this.type);

  final DsButtonType type;

  @override
  Widget build(BuildContext context) {
    Widget row([DsButtonState? state]) => Row(
      spacing: 10,
      children: [
        Expanded(
          child: DsButton(type: type, text: 'Enabled', state: state),
        ),
        Expanded(
          child: DsButton(
            type: type,
            text: 'Enabled',
            state: state,
            isDanger: true,
          ),
        ),
      ],
    );
    return Column(
      crossAxisAlignment: .start,
      spacing: 10,
      children: [
        DsText(type.name.toUpperCase()),
        row(),
        row(.loading),
        row(.disabled),
      ],
    );
  }
}
