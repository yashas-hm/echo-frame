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

  final bool left;
  final VoidCallback onPressed;
  final bool loadingNext;

  @override
  State<CaretArrow> createState() => _CaretArrowState();
}

class _CaretArrowState extends State<CaretArrow> {
  bool _hovering = false;
  static const double _zoneWidth = 80;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: widget.left ? 0 : null,
      right: widget.left ? null : 0,
      top: 0,
      bottom: 0,
      width: _zoneWidth,
      child: MouseRegion(
        onEnter: (_) => setState(() => _hovering = true),
        onExit: (_) => setState(() => _hovering = false),
        child: AnimatedOpacity(
          opacity: _hovering ? 1.0 : 0.0,
          duration: Durations.short3,
          child: IgnorePointer(
            ignoring: !_hovering,
            child: Material(
              color: KnownColors.transparent,
              child: InkWell(
                onTap: widget.onPressed,
                splashColor: context.colors.onPrimary.withValues(alpha: 0.3),
                child: Container(
                  width: _zoneWidth,
                  height: double.infinity,
                  color: context.colors.surfacePrimary.withValues(alpha: 0.1),
                  child: Center(
                    child: widget.loadingNext && !widget.left
                        ? SizedBox(
                            height: 20,
                            width: 20,
                            child: CircularProgressIndicator(
                              valueColor: AlwaysStoppedAnimation(
                                  context.colors.onPrimary),
                            ),
                          )
                        : Icon(
                            widget.left
                                ? Icons.arrow_back_ios_rounded
                                : Icons.arrow_forward_ios_rounded,
                            size: 25,
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
