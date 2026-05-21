import 'package:ds_well/src/components/text/ds_text.dart';
import 'package:ds_well/src/theme/ds_theme.dart';
import 'package:ds_well/src/theme/ds_theme_preview.dart';
import 'package:flutter/widgets.dart';
import 'package:skeletonizer/skeletonizer.dart';

sealed class DsShimmer implements Widget {
  const factory({
    required Widget child,
    bool enabled,
    Key? key,
  }) = _DsShimmer;

  /// Creates a widget that keeps paints the original child as is when
  /// [DsShimmer] enabled is true
  const factory keep({
    required Widget child,
    Key? key,
  }) = _DsShimmerKeep;

  const factory leaf({
    required Widget child,
    Key? key,
  }) = _DsShimmerLeaf;
}

class const _DsShimmerKeep({
  required final Widget child,
  super.key,
}) extends StatelessWidget implements DsShimmer {
  @override
  Widget build(BuildContext context) => Skeleton.keep(child: child);
}

class const _DsShimmerLeaf({
  required final Widget child,
  super.key,
}) extends StatelessWidget implements DsShimmer {
  @override
  Widget build(BuildContext context) => Skeleton.leaf(child: child);
}

class const _DsShimmer({
  required final Widget child,
  final bool enabled = true,
  super.key,
}) extends StatefulWidget implements DsShimmer {
  @override
  State<_DsShimmer> createState() => _DsShimmerState();
}

class _DsShimmerState extends State<_DsShimmer> {
  late final _enabled = ValueNotifier(widget.enabled);
  late final _child = ValueNotifier(widget.child);

  @override
  void didUpdateWidget(_DsShimmer oldWidget) {
    super.didUpdateWidget(oldWidget);
    _enabled.value = widget.enabled;
    _child.value = widget.child;
  }

  @override
  void dispose() {
    _enabled.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => const _Skeletonizer();
}

class const _Skeletonizer() extends StatefulWidget {
  @override
  State<_Skeletonizer> createState() => _SkeletonizerState();
}

class _SkeletonizerState extends State<_Skeletonizer> {
  late ShimmerEffect _effect;
  Color? _shimmerColor;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final shimmerColor = switch (DsTheme.of(context).brightness) {
      .dark => Color.fromARGB(255, 68, 68, 68),
      .light => Color.fromARGB(255, 221, 221, 221),
    };
    if (shimmerColor != _shimmerColor) {
      _shimmerColor = shimmerColor;
      _effect = ShimmerEffect.raw(
        duration: const Duration(milliseconds: 2500),
        stops: const [0.2, 0.5, 0.8],
        tileMode: TileMode.repeated,
        colors: [
          shimmerColor.withValues(alpha: 0.7),
          shimmerColor.withValues(alpha: 0.3),
          shimmerColor.withValues(alpha: 0.7),
        ],
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final parent = context.findAncestorStateOfType<_DsShimmerState>()!;
    return ValueListenableBuilder(
      valueListenable: parent._enabled,
      builder: (context, enabled, child) {
        return Skeletonizer(
          effect: _effect,
          enabled: enabled,
          child: child!,
        );
      },
      child: ValueListenableBuilder(
        valueListenable: parent._child,
        builder: (context, child, _) => child,
      ),
    );
  }
}

@DsThemePreview(group: 'DsShimmer')
WidgetBuilder dsShimmer() =>
    (context) => DsShimmer(
      child: Column(
        spacing: 10,
        children: [
          DsShimmer.keep(child: DsText('shimmer')),
          DsText('shimmer'),
          Container(
            width: DsThemePreview.minWidth,
            height: 20,
            color: DsTheme.of(context).background.secondary,
          ),
          Row(
            spacing: 5,
            mainAxisSize: .min,
            children: [
              for (var i = 0; i < 8; i++)
                DsShimmer.leaf(
                  child: Container(
                    height: 20,
                    width: 20,
                    decoration: BoxDecoration(
                      color: DsTheme.of(context).background.secondary,
                      shape: .circle,
                    ),
                  ),
                ),
            ],
          ),
        ],
      ),
    );
