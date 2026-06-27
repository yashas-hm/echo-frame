part of '../favorites_screen.dart';

class FavoritesNotifier extends MediaCollectionNotifier {
  @override
  MediaCollectionSource get source => MediaCollectionSource.favorites;
}

final favoritesProvider =
    AsyncNotifierProvider<FavoritesNotifier, MediaCollectionState>(
        FavoritesNotifier.new);
