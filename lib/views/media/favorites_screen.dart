import 'dart:developer' as dev;

import 'package:echo_frame/components/error_view.dart';
import 'package:echo_frame/utilities/utilities.dart' show ContextExtensions;
import 'package:echo_frame/views/media/components/empty_view.dart';
import 'package:echo_frame/views/media/components/loading_view.dart';
import 'package:echo_frame/views/media/components/photo_tile.dart';
import 'package:echo_frame/views/media/provider/favorites_provider.dart';
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
        loading: () => const LoadingView(text: 'Loading favourites'),
        error: (e, st) {
          dev.log(
            'Failed to load favourites: $e',
            stackTrace: st,
            name: 'FavoritesScreen.build',
          );
          return ErrorView(
            errorMessage: 'Failed to load favourites',
            description: 'Something unexpected occurred. Please try again.',
            buttonText: 'Try Again',
            onButtonPressed: () => ref.invalidate(favoritesProvider),
          );
        },
        data: (state) {
          final items = state.flatItems;
          if (items.isEmpty) {
            return const EmptyView(
              icon: Icons.favorite_outline_rounded,
              title: 'No media starred yet',
              message: 'Open a photo and tap the star to save it here',
            );
          }
          return CustomScrollView(
            slivers: [
              SliverPadding(
                padding: const EdgeInsets.fromLTRB(0, 16, 0, 0),
                sliver: SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Text(
                      '${items.length} favourite${items.length == 1 ? '' : 's'}',
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
}