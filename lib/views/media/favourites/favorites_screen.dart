import 'dart:developer' as dev;

import 'package:echo_frame/components/empty_view.dart';
import 'package:echo_frame/components/error_view.dart';
import 'package:echo_frame/constants/constants.dart' show Sizes;
import 'package:echo_frame/views/media/components/loading_view.dart';
import 'package:echo_frame/views/media/components/media_list_view.dart';
import 'package:echo_frame/views/media/components/search_bar.dart';import 'package:echo_frame/views/media/provider/media_collection_notifier.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

export 'package:echo_frame/views/media/provider/media_collection_notifier.dart'
    show MediaCollectionState;
import 'package:echo_frame/views/media/provider/media_collection_notifier.dart'
    show MediaCollectionSource;
import 'package:echo_frame/views/media/provider/search_focus_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

part './provider/favorites_provider.dart';

class FavoritesScreen extends ConsumerWidget {
  const FavoritesScreen({super.key});

  static const String path = '/favorites';

  static GoRoute get route => GoRoute(
        path: path,
        builder: (_, __) => const FavoritesScreen(),
      );

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final favoriteAsync = ref.watch(favoritesProvider);

    return Scaffold(
      body: Padding(
        padding: EdgeInsets.only(
          left: Sizes.spacingSmall,
          top: Sizes.edgePadding,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            EFSearchBar(
              focusNode: ref.read(searchFocusProvider),
              initialQuery: favoriteAsync.value?.query ?? '',
              onTextChanged: (q) =>
                  ref.read(favoritesProvider.notifier).setQuery(q),
            ),
            Flexible(
              child: favoriteAsync.when(
                loading: () => const LoadingView(text: 'Loading favourites'),
                error: (e, st) {
                  dev.log(
                    'Failed to load favourites: $e',
                    stackTrace: st,
                    name: 'FavoritesScreen.build',
                  );
                  return ErrorView(
                    errorMessage: 'Failed to load favourites',
                    description:
                        'Something unexpected occurred. Please try again.',
                    buttonText: 'Try Again',
                    onButtonPressed: () => ref.invalidate(favoritesProvider),
                  );
                },
                data: (favorite) {
                  final items = favorite.flatItems;
                  if (items.isEmpty) {
                    return const EmptyView(
                      icon: Icons.favorite_outline_rounded,
                      title: 'No media starred yet',
                      message: 'Open a photo and tap the star to save it here',
                    );
                  }
                  return MediaListView(
                    state: favorite,
                    source: MediaCollectionSource.favorites,
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
