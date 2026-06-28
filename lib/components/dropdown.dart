import 'package:echo_frame/constants/constants.dart' show Sizes;
import 'package:echo_frame/theme/theme.dart';
import 'package:echo_frame/utilities/utilities.dart' show ContextExtensions;
import 'package:flutter/material.dart';

class EFDropdown<T> extends StatelessWidget {
  const EFDropdown({
    super.key,
    required this.value,
    required this.items,
    required this.onChanged,
    this.hint,
    this.icon = Icons.arrow_drop_down_rounded,
  });

  final T? value;
  final List<DropdownMenuItem<T>> items;
  final ValueChanged<T?> onChanged;
  final Widget? hint;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;

    return DropdownButton<T>(
      value: value,
      hint: hint,
      dropdownColor: colors.surfacePrimary,
      borderRadius: BorderRadius.circular(Sizes.inputBorderRadius),
      padding: EdgeInsets.symmetric(horizontal: Sizes.spacingRegular),
      focusColor: KnownColors.transparent,
      mouseCursor: SystemMouseCursors.click,
      icon: Icon(
        icon,
        size: Sizes.iconSizeSmall,
        color: colors.textPrimary,
      ),
      underline: const SizedBox.shrink(),
      items: items,
      onChanged: onChanged,
    );
  }
}
