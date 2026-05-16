import 'package:ds_well/src/components/text/ds_text.dart';
import 'package:ds_well/src/theme/ds_theme.dart';
import 'package:ds_well/src/theme/ds_theme_preview.dart';
import 'package:flutter/widgets.dart';
import 'package:skeletonizer/skeletonizer.dart';

sealed class DsShimmer extends Widget {
  const factory DsShimmer({
    required Widget child,
    bool enabled,
    Key? key,
  }) = _DsShimmer;

  /// Creates a widget that keeps paints the original child as is when
  /// [DsShimmer] enabled is true
  const factory DsShimmer.keep({
    required Widget child,
    Key? key,
  }) = _DsShimmerKeep;

  const factory DsShimmer.leaf({
    required Widget child,
    Key? key,
  }) = _DsShimmerLeaf;
}

// ignore: avoid_implementing_value_types
class _DsShimmerKeep extends StatelessWidget implements DsShimmer {
  const _DsShimmerKeep({
    required this.child,
    super.key,
  });

  final Widget child;

  @override
  Widget build(BuildContext context) => Skeleton.keep(child: child);
}

// ignore: avoid_implementing_value_types
class _DsShimmerLeaf extends StatelessWidget implements DsShimmer {
  const _DsShimmerLeaf({
    required this.child,
    super.key,
  });

  final Widget child;

  @override
  Widget build(BuildContext context) => Skeleton.leaf(child: child);
}

// ignore: avoid_implementing_value_types
class _DsShimmer extends StatefulWidget implements DsShimmer {
  const _DsShimmer({
    required this.child,
    this.enabled = true,
    super.key,
  });
  final Widget child;
  final bool enabled;

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

class _Skeletonizer extends StatefulWidget {
  const _Skeletonizer();

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
      .dark => Color(0xFF444444),
      .light => Color(0xFFDDDDDD),
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
