import 'dart:async';

import 'package:echo_frame/components/buttons/buttons.dart';
import 'package:echo_frame/constants/constants.dart' show Sizes, Styles;
import 'package:echo_frame/theme/theme.dart';
import 'package:echo_frame/utilities/utilities.dart' show ContextExtensions;
import 'package:flutter/material.dart';

class EFSearchBar extends StatefulWidget {
  const EFSearchBar({
    super.key,
    required this.onTextChanged,
    required this.focusNode,
    this.initialQuery = '',
  });

  final ValueChanged<String> onTextChanged;
  final String initialQuery;
  final FocusNode focusNode;

  @override
  State<EFSearchBar> createState() => _EFSearchBarState();
}

class _EFSearchBarState extends State<EFSearchBar> {
  final _controller = TextEditingController();
  Timer? _debounce;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_controller.text != widget.initialQuery) {
        _controller.text = widget.initialQuery;
      }
    });
  }

  @override
  void didUpdateWidget(covariant EFSearchBar oldWidget) {
    if (_controller.text != widget.initialQuery) {
      _controller.text = widget.initialQuery;
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    _debounce?.cancel();
    _controller.dispose();
    super.dispose();
  }

  void _onChanged(String value) {
    _debounce?.cancel();
    _debounce = Timer(Durations.medium3, () {
      widget.onTextChanged(value.trim());
    });
  }

  void _clear() {
    _controller.clear();
    _debounce?.cancel();
    widget.onTextChanged('');
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    return Container(
      height: Sizes.inputHeight,
      width: context.width * 0.7,
      margin: EdgeInsets.only(
        right: Sizes.edgePadding,
      ),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: colors.surfacePrimary,
        borderRadius: BorderRadius.circular(Sizes.maxFinite),
        boxShadow: [
          BoxShadow(
            color: colors.borderPrimary.withValues(alpha: 0.5),
            spreadRadius: 0.8,
            blurRadius: 4,
          )
        ],
      ),
      clipBehavior: Clip.antiAlias,
      padding: EdgeInsets.all(Sizes.spacingSmallRegular),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        spacing: Sizes.spacingExtraSmall,
        children: [
          Icon(
            Icons.search_rounded,
            color: colors.textSecondary,
          ),
          Expanded(
            child: TextField(
              controller: _controller,
              focusNode: widget.focusNode,
              onChanged: _onChanged,
              decoration: InputDecoration(
                fillColor: KnownColors.transparent,
                hintText: 'Search',
                hoverColor: KnownColors.transparent,
                contentPadding: EdgeInsets.zero,
                border: Styles.borderNone,
                enabledBorder: Styles.borderNone,
                focusedBorder: Styles.borderNone,
                filled: true,
              ),
            ),
          ),
          ValueListenableBuilder(
            valueListenable: _controller,
            builder: (_, value, __) => value.text.isEmpty
                ? const SizedBox.shrink()
                : EFIconButton(
                    icon: Icons.clear_rounded,
                    onPressed: _clear,
                    iconPadding: EdgeInsets.all(
                      Sizes.spacingExtraExtraSmall,
                    ),
                    iconSize: Sizes.iconSizeSmallRegular,
                    iconColor: colors.textSecondary,
                  ),
          ),
        ],
      ),
    );
  }
}
