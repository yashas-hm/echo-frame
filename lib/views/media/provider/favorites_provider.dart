import 'package:echo_frame/views/media/provider/media_collection_notifier.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

export 'package:echo_frame/views/media/provider/media_collection_notifier.dart'
    show MediaCollectionState;

class FavoritesNotifier extends MediaCollectionNotifier {
  @override
  MediaCollectionSource get source => MediaCollectionSource.favorites;
}

final favoritesProvider =
    AsyncNotifierProvider<FavoritesNotifier, MediaCollectionState>(
        FavoritesNotifier.new);