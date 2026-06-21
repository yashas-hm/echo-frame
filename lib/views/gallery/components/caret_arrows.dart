import 'package:echo_frame/constants/constants.dart' show Sizes;
import 'package:echo_frame/theme/theme.dart';
import 'package:echo_frame/utilities/utilities.dart';
import 'package:flutter/material.dart';

class CaretArrow extends StatefulWidget {
  const CaretArrow({
    super.key,
    required this.onPressed,
    this.loadingNext = false,
    this.left = false,
  });

  final VoidCallback onPressed;
  final bool loadingNext;
  final bool left;

  @override
  State<CaretArrow> createState() => _CaretArrowState();
}

class _CaretArrowState extends State<CaretArrow> {
  bool _hovering = false;
  static const double _zoneWidth = 80;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;

    return Align(
      alignment: widget.left ? Alignment.centerLeft : Alignment.centerRight,
      child: SizedBox(
        width: _zoneWidth,
        height: context.height * 0.55,
        child: MouseRegion(
          onEnter: (_) => setState(() => _hovering = true),
          onExit: (_) => setState(() => _hovering = false),
          child: AnimatedOpacity(
            opacity: _hovering ? 1.0 : 0.0,
            duration: Durations.short3,
            child: IgnorePointer(
              ignoring: !_hovering,
              child: ClipRRect(
                borderRadius: BorderRadius.only(
                  topLeft: widget.left
                      ? Radius.zero
                      : Radius.circular(Sizes.maxFinite),
                  bottomLeft: widget.left
                      ? Radius.zero
                      : Radius.circular(Sizes.maxFinite),
                  topRight: widget.left
                      ? Radius.circular(Sizes.maxFinite)
                      : Radius.zero,
                  bottomRight: widget.left
                      ? Radius.circular(Sizes.maxFinite)
                      : Radius.zero,
                ),
                child: Material(
                  color: KnownColors.transparent,
                  child: InkWell(
                    mouseCursor: SystemMouseCursors.click,
                    onTap: widget.onPressed,
                    hoverColor: KnownColors.transparent,
                    splashColor: colors.onPrimary.splash,
                    child: Container(
                      width: _zoneWidth,
                      height: double.infinity,
                      color: colors.surfacePrimary.hover,
                      child: Center(
                        child: widget.loadingNext && !widget.left
                            ? SizedBox(
                                height: Sizes.iconSizeRegular,
                                width: Sizes.iconSizeRegular,
                                child: CircularProgressIndicator(
                                  valueColor: AlwaysStoppedAnimation(
                                    colors.textPrimary,
                                  ),
                                ),
                              )
                            : Icon(
                                widget.left
                                    ? Icons.arrow_back_ios_rounded
                                    : Icons.arrow_forward_ios_rounded,
                                size: Sizes.iconSizeLarge,
                                color: colors.textPrimary,
                              ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
