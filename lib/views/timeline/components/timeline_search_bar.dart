import 'dart:async';
import 'dart:ui';

import 'package:echo_frame/theme/theme.dart';
import 'package:echo_frame/utilities/utilities.dart';
import 'package:echo_frame/views/timeline/provider/timeline_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TimelineSearchBar extends ConsumerStatefulWidget {
  const TimelineSearchBar({super.key});

  static const double height = 68.0;

  @override
  ConsumerState<TimelineSearchBar> createState() => _TimelineSearchBarState();
}

class _TimelineSearchBarState extends ConsumerState<TimelineSearchBar> {
  final _controller = TextEditingController();
  Timer? _debounce;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final query = ref.read(timelineProvider).value?.query ?? '';
      if (_controller.text != query) _controller.text = query;
    });
  }

  @override
  void dispose() {
    _debounce?.cancel();
    _controller.dispose();
    super.dispose();
  }

  void _onChanged(String value) {
    _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 350), () {
      ref.read(timelineProvider.notifier).setQuery(value.trim());
    });
  }

  void _clear() {
    _controller.clear();
    _debounce?.cancel();
    ref.read(timelineProvider.notifier).setQuery('');
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    return SizedBox(
      height: TimelineSearchBar.height,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 12, 16, 8),
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
              TextField(
                controller: _controller,
                onChanged: _onChanged,
                decoration: InputDecoration(
                  fillColor: KnownColors.transparent,
                  prefixIcon: Icon(Icons.search_rounded,
                      color: colors.textPrimary.withValues(alpha: 0.5)),
                  hintText: 'Search',
                  hoverColor: KnownColors.transparent,
                  suffixIcon: ValueListenableBuilder(
                    valueListenable: _controller,
                    builder: (_, value, __) => value.text.isEmpty
                        ? const SizedBox.shrink()
                        : IconButton(
                            icon: Icon(Icons.close_rounded,
                                color: colors.textPrimary.withValues(alpha: 0.5)),
                            onPressed: _clear,
                          ),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(100),
                    borderSide: BorderSide.none,
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(100),
                    borderSide: BorderSide.none,
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(100),
                    borderSide: BorderSide.none,
                  ),
                  filled: true,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
