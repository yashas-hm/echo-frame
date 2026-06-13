import 'package:echo_frame/models/media_item.dart';
import 'package:echo_frame/views/favorites/provider/favorites_provider.dart';
import 'package:echo_frame/views/timeline/photo_tile.dart';
import 'package:echo_frame/utilities/utilities.dart' show ContextExtension;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class FavoritesScreen extends ConsumerWidget {
  const FavoritesScreen({super.key});

  static const String path = '/favorites';

  static GoRoute get route => GoRoute(
        path: path,
        builder: (_, __) => const FavoritesScreen(),
      );

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(favoritesProvider);

    return Scaffold(
      body: state.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('Error: $e')),
        data: (records) {
          if (records.isEmpty) {
            return _buildEmpty(context);
          }
          final items = records.map(MediaItem.fromRecord).toList();
          return CustomScrollView(
            slivers: [
              SliverPadding(
                padding: const EdgeInsets.fromLTRB(0, 16, 0, 0),
                sliver: SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Text(
                      '${records.length} favourite${records.length == 1 ? '' : 's'}',
                      style: Theme.of(context)
                          .textTheme
                          .labelSmall
                          ?.copyWith(color: context.colors.textSecondary),
                    ),
                  ),
                ),
              ),
              const SliverToBoxAdapter(child: SizedBox(height: 12)),
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
            ],
          );
        },
      ),
    );
  }

  Widget _buildEmpty(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.favorite_outline_rounded,
              size: 56, color: context.colors.borderPrimary),
          const SizedBox(height: 16),
          Text(
            'No favourites yet',
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(height: 6),
          Text(
            'Open a photo and tap the heart to save it here',
            style: Theme.of(context)
                .textTheme
                .bodySmall
                ?.copyWith(color: context.colors.textSecondary),
          ),
        ],
      ),
    );
  }
}
