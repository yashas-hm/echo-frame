import 'dart:async';
import 'dart:ui';

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
      child: ClipRRect(
        borderRadius: BorderRadius.circular(100),
        child: Stack(
          children: [
            Positioned.fill(
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
                child: Container(
                  decoration: BoxDecoration(
                    color: colors.textPrimary.withValues(alpha: 0.08),
                    borderRadius: BorderRadius.circular(100),
                    border: Border.all(
                      color: colors.textPrimary.withValues(alpha: 0.15),
                      width: 1,
                    ),
                  ),
                ),
              ),
            ),
            Center(
              child: Padding(
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
              ),
            ),
          ],
        ),
      ),
    );
  }
}
