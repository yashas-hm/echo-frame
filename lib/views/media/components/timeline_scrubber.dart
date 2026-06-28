import 'dart:async';

import 'package:echo_frame/constants/constants.dart' show Styles, Sizes;
import 'package:echo_frame/models/month_count.dart';
import 'package:echo_frame/theme/theme.dart';
import 'package:echo_frame/utilities/utilities.dart'
    show ContextExtensions;
import 'package:flutter/foundation.dart' show listEquals;
import 'package:flutter/material.dart';
import 'package:intl/intl.dart' show DateFormat;

class TimelineScrubber extends StatefulWidget {
  const TimelineScrubber({
    super.key,
    required this.monthCounts,
    required this.totalCount,
    required this.scrollController,
    required this.onJumpToPage,
  });

  final List<MonthCount> monthCounts;
  final int totalCount;
  final ScrollController scrollController;
  final void Function(int pageIndex) onJumpToPage;

  @override
  State<TimelineScrubber> createState() => _TimelineScrubberState();
}

class _TimelineScrubberState extends State<TimelineScrubber> {
  static final _monthFmt = DateFormat('MMM yyyy');

  Timer? _debounce;
  double? _hoverFraction;
  bool _isDragging = false;

  MonthCount _monthAtFraction(double fraction) {
    var accumulated = 0;
    for (final m in widget.monthCounts) {
      accumulated += m.count;
      if (accumulated / widget.totalCount >= fraction) return m;
    }
    return widget.monthCounts.last;
  }

  double _estimateScrollOffset(BuildContext context, MonthCount target) {
    final viewportWidth = context.width;
    final tilesPerRow = ((viewportWidth + 2) / 182).floor();
    var offset = 0.0;
    for (final m in widget.monthCounts) {
      if (m == target) break;
      offset += (m.count / tilesPerRow).ceil() * 182.0 + 52.0;
    }
    return offset;
  }

  void _jumpToFraction(BuildContext context, double fraction) {
    if (widget.totalCount == 0) return;
    final target = _monthAtFraction(fraction);
    final estimatedOffset = _estimateScrollOffset(context, target);
    if (widget.scrollController.hasClients) {
      widget.scrollController.jumpTo(
        estimatedOffset.clamp(
          0.0,
          widget.scrollController.position.maxScrollExtent,
        ),
      );
    }
    _debounce?.cancel();
    _debounce = Timer(Durations.short2, () {
      widget.onJumpToPage(target.globalOffset ~/ 100);
    });
  }

  @override
  void dispose() {
    _debounce?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    return LayoutBuilder(
      builder: (context, constraints) {
        final height = constraints.maxHeight;
        final hoverY = _hoverFraction != null ? _hoverFraction! * height : null;
        final hoveredMonth = _hoverFraction != null && widget.totalCount > 0
            ? _monthAtFraction(_hoverFraction!)
            : null;

        return MouseRegion(
          onHover: (e) => setState(
            () =>
                _hoverFraction = (e.localPosition.dy / height).clamp(0.0, 1.0),
          ),
          onExit: (_) => setState(() => _hoverFraction = null),
          child: GestureDetector(
            onTapUp: (d) => _jumpToFraction(
              context,
              (d.localPosition.dy / height).clamp(0.0, 1.0),
            ),
            onVerticalDragStart: (_) => setState(() => _isDragging = true),
            onVerticalDragUpdate: (d) {
              final fraction = (d.localPosition.dy / height).clamp(0.0, 1.0);
              setState(() => _hoverFraction = fraction);
              _jumpToFraction(context, fraction);
            },
            onVerticalDragEnd: (_) => setState(() => _isDragging = false),
            child: SizedBox(
              height: height,
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  // Layer 1: static — year chips + month dots
                  CustomPaint(
                    size: Size(Sizes.inputHeight, height),
                    painter: _StaticScrubberPainter(
                      monthCounts: widget.monthCounts,
                      totalCount: widget.totalCount,
                      colors: colors,
                    ),
                  ),
                  // Layer 2: scroll position indicator
                  if (hoverY == null && !_isDragging)
                    ListenableBuilder(
                      listenable: widget.scrollController,
                      builder: (_, __) {
                        final ctrl = widget.scrollController;
                        if (!ctrl.hasClients) return const SizedBox.shrink();
                        final pos = ctrl.position;
                        if (pos.maxScrollExtent == 0) {
                          return const SizedBox.shrink();
                        }
                        final fraction = pos.pixels / pos.maxScrollExtent;
                        return Positioned(
                          top: (fraction * height).clamp(0.0, height - 1.5),
                          right: 0,
                          child: Container(
                            height: 1.5,
                            width: 60,
                            color: colors.secondaryColor,
                          ),
                        );
                      },
                    ),
                  // Layer 3: hover / drag line
                  if (hoverY != null && hoveredMonth != null)
                    Positioned(
                      top: hoverY.clamp(0.0, height - 1.5),
                      right: 0,
                      child: _hoverIndicator(hoveredMonth),
                    ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _hoverIndicator(MonthCount month) {
    final colors = context.colors;
    final label = _monthFmt.format(DateTime(month.year, month.month));
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      decoration: BoxDecoration(
        color: colors.surfacePrimary,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(2),
          bottomLeft: Radius.circular(2),
        ),
        border: Border(
          bottom: BorderSide(
            color: colors.secondaryColor,
            width: 1.5,
          ),
        ),
      ),
      child: Text(
        label,
        style: Styles.microBold(color: colors.textPrimary),
      ),
    );
  }
}

class _StaticScrubberPainter extends CustomPainter {
  _StaticScrubberPainter({
    required this.monthCounts,
    required this.totalCount,
    required this.colors,
  }) : _bgPaint = Paint()
          ..color = colors.textPrimary.withValues(alpha: 0.5);

  final List<MonthCount> monthCounts;
  final int totalCount;
  final AppThemeColors colors;
  final Paint _bgPaint;

  @override
  void paint(Canvas canvas, Size size) {
    if (totalCount == 0) return;
    int? lastYear;
    var accumulated = 0;

    for (final m in monthCounts) {
      final y = (accumulated / totalCount) * size.height;

      if (m.year != lastYear) {
        lastYear = m.year;
        final tp = TextPainter(
          text: TextSpan(
            text: m.year.toString(),
            style: Styles.microBold(color: colors.background),
          ),
          textDirection: TextDirection.ltr,
        )..layout(maxWidth: size.width);
        const hPad = 6.0;
        const vPad = 2.0;
        canvas.drawRRect(
          RRect.fromLTRBR(
            0,
            y - vPad,
            tp.width + hPad * 2,
            y + tp.height + vPad,
            Radius.circular(Sizes.maxFinite),
          ),
          _bgPaint,
        );
        tp.paint(canvas, Offset(hPad, y));
      } else {
        canvas.drawCircle(
          Offset(size.width - 8, y),
          2.5,
          _bgPaint,
        );
      }

      accumulated += m.count;
    }
  }

  @override
  bool shouldRepaint(_StaticScrubberPainter old) =>
      !listEquals(old.monthCounts, monthCounts) ||
      old.totalCount != totalCount ||
      old.colors != colors;
}
