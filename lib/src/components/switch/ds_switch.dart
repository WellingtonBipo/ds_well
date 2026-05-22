import 'package:ds_well/src/theme/ds_theme.dart';
import 'package:ds_well/src/theme/ds_theme_preview.dart';
import 'package:ds_well/src/utils/color_extension.dart';
import 'package:flutter/material.dart' show Switch;
import 'package:flutter/widgets.dart';

class DsSwitch extends StatelessWidget {
  const DsSwitch({
    required this.value,
    this.onChanged,
    super.key,
  });

  final bool value;
  final void Function(bool e)? onChanged;

  @override
  Widget build(BuildContext context) {
    final theme = DsTheme.of(context);

    final transparent = Color.fromARGB(0, 0, 0, 0);
    final thumbEnabledUnselected = switch (theme.brightness) {
      .light => theme.background.tertiary.changeTune(0.6),
      .dark => theme.background.tertiary.changeTune(3),
    };
    return Switch(
      value: value,
      onChanged: onChanged,
      thumbColor: _WidgetStateProperty(
        enabledSelected: theme.components.switchBtn.color,
        enabledUnselected: thumbEnabledUnselected,
        disabledSelected: switch (theme.brightness) {
          .light => theme.background.tertiary.changeTune(0.8),
          .dark => theme.background.tertiary.changeTune(1.8),
        },
        disabledUnselected: theme.background.tertiary,
      ),
      trackColor: _WidgetStateProperty(
        enabledSelected: theme.components.switchBtn.color.withAlpha(130),
        enabledUnselected: transparent,
        disabledSelected: theme.background.tertiary,
        disabledUnselected: transparent,
      ),
      trackOutlineColor: _WidgetStateProperty(
        enabledSelected: transparent,
        enabledUnselected: thumbEnabledUnselected,
        disabledSelected: transparent,
        disabledUnselected: theme.background.tertiary,
      ),
    );
  }
}

class _WidgetStateProperty({
  required final Color enabledSelected,
  required final Color enabledUnselected,
  required final Color disabledSelected,
  required final Color disabledUnselected,
}) extends WidgetStateProperty<Color> {
  //
  @override
  Color resolve(Set<WidgetState> states) {
    if (states.contains(WidgetState.selected) &&
        states.contains(WidgetState.disabled)) {
      return disabledSelected;
    }
    if (states.contains(WidgetState.selected)) return enabledSelected;
    if (states.contains(WidgetState.disabled)) return disabledUnselected;
    return enabledUnselected;
  }
}

@DsThemePreview(group: 'DsSwitch')
Widget dsSwitchPreview() {
  var value = true;
  return StatefulBuilder(
    builder: (context, setState) => Row(
      mainAxisAlignment: .center,
      children: [
        DsSwitch(value: value),
        DsSwitch(
          value: value,
          onChanged: (e) => setState(() => value = e),
        ),
      ],
    ),
  );
}
