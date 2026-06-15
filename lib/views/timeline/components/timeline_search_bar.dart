import 'dart:async';

import 'package:echo_frame/views/timeline/provider/timeline_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TimelineSearchBar extends ConsumerStatefulWidget {
  const TimelineSearchBar({super.key});

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
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 8),
      child: TextField(
        controller: _controller,
        onChanged: _onChanged,
        decoration: InputDecoration(
          prefixIcon: const Icon(Icons.search_rounded),
          hintText: 'Search',
          suffixIcon: ValueListenableBuilder(
            valueListenable: _controller,
            builder: (_, value, __) => value.text.isEmpty
                ? const SizedBox.shrink()
                : IconButton(
                    icon: const Icon(Icons.close_rounded),
                    onPressed: _clear,
                  ),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
          filled: true,
        ),
      ),
    );
  }
}