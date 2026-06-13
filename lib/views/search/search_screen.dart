import 'dart:async';

import 'package:echo_frame/database/database.dart';
import 'package:echo_frame/models/media_item.dart';
import 'package:echo_frame/utilities/utilities.dart' show ContextExtension;
import 'package:echo_frame/views/search/provider/search_provider.dart';
import 'package:echo_frame/views/timeline/photo_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class SearchScreen extends ConsumerStatefulWidget {
  const SearchScreen({super.key});

  static const String path = '/search';

  static GoRoute get route => GoRoute(
        path: path,
        builder: (_, __) => const SearchScreen(),
      );

  @override
  ConsumerState<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends ConsumerState<SearchScreen> {
  final _controller = TextEditingController();
  Timer? _debounce;

  @override
  void dispose() {
    _debounce?.cancel();
    _controller.dispose();
    super.dispose();
  }

  void _onChanged(String value) {
    _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 350), () {
      ref.read(searchProvider.notifier).search(value);
    });
  }

  void _onClear() {
    _controller.clear();
    _debounce?.cancel();
    ref.read(searchProvider.notifier).clear();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(searchProvider);

    return Scaffold(
      body: Column(
        children: [
          // ── Search bar ──────────────────────────────────────────────────
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 20, 20, 12),
            child: SearchBar(
              controller: _controller,
              hintText: 'Search by filename, camera…',
              leading: const Icon(Icons.search_rounded),
              trailing: [
                if (_controller.text.isNotEmpty)
                  IconButton(
                    icon: const Icon(Icons.close_rounded),
                    onPressed: _onClear,
                  ),
              ],
              onChanged: _onChanged,
              elevation: const WidgetStatePropertyAll(0),
              side: WidgetStatePropertyAll(
                BorderSide(color: context.colors.borderPrimary),
              ),
              shape: const WidgetStatePropertyAll(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
              ),
            ),
          ),

          // ── Results ─────────────────────────────────────────────────────
          Expanded(
            child: state.when(
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (e, _) => Center(child: Text('Error: $e')),
              data: (records) {
                if (_controller.text.trim().isEmpty) {
                  return _buildHint(context);
                }
                if (records.isEmpty) {
                  return _buildNoResults(context);
                }
                return _buildGrid(records);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildGrid(List<MediaRecord> records) {
    final items = records.map(MediaItem.fromRecord).toList();
    return CustomScrollView(
      slivers: [
        SliverPadding(
          padding: const EdgeInsets.all(2),
          sliver: SliverGrid.builder(
            gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: 180,
              crossAxisSpacing: 2,
              mainAxisSpacing: 2,
            ),
            itemCount: items.length,
            itemBuilder: (_, i) => PhotoTile(item: items[i]),
          ),
        ),
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Center(
              child: Text(
                '${records.length} result${records.length == 1 ? '' : 's'}',
                style: Theme.of(context)
                    .textTheme
                    .bodySmall
                    ?.copyWith(color: context.colors.textSecondary),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildHint(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.search_rounded,
              size: 56, color: context.colors.borderPrimary),
          const SizedBox(height: 16),
          Text(
            'Search your library',
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(height: 6),
          Text(
            'Filename, camera make, or camera model',
            style: Theme.of(context)
                .textTheme
                .bodySmall
                ?.copyWith(color: context.colors.textSecondary),
          ),
        ],
      ),
    );
  }

  Widget _buildNoResults(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.image_search_rounded,
              size: 56, color: context.colors.borderPrimary),
          const SizedBox(height: 16),
          Text(
            'No results for "${_controller.text.trim()}"',
            style: Theme.of(context).textTheme.titleMedium,
          ),
        ],
      ),
    );
  }
}
