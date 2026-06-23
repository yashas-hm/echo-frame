import 'dart:developer' as dev;

import 'package:echo_frame/components/empty_view.dart';
import 'package:echo_frame/components/error_view.dart';
import 'package:echo_frame/views/media/components/loading_view.dart';
import 'package:echo_frame/views/media/components/media_list_view.dart';
import 'package:echo_frame/views/media/components/search_bar.dart';
import 'package:echo_frame/views/media/provider/favorites_provider.dart';
import 'package:echo_frame/views/media/provider/search_focus_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class FavoritesScreen extends ConsumerStatefulWidget {
  const FavoritesScreen({super.key});

  static const String path = '/favorites';

  static GoRoute get route => GoRoute(
        path: path,
        builder: (_, __) => const FavoritesScreen(),
      );

  @override
  ConsumerState<FavoritesScreen> createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends ConsumerState<FavoritesScreen> {
  final _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 300) {
      ref.read(favoritesProvider.notifier).loadNextPage();
    }
  }

  @override
  Widget build(BuildContext context) {
    final favoriteAsync = ref.watch(favoritesProvider);

    return Scaffold(
      body: Stack(
        children: [
          favoriteAsync.when(
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
                scrollController: _scrollController,
              );
            },
          ),
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: EFSearchBar(
              focusNode: ref.read(searchFocusProvider),
              initialQuery: favoriteAsync.value?.query ?? '',
              onTextChanged: (q) =>
                  ref.read(favoritesProvider.notifier).setQuery(q),
            ),
          ),
        ],
      ),
    );
  }
}
