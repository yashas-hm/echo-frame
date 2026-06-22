import 'package:echo_frame/views/collection/provider/media_collection_notifier.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

export 'package:echo_frame/views/collection/provider/media_collection_notifier.dart'
    show MediaCollectionState;

class FavoritesNotifier extends MediaCollectionNotifier {
  @override
  bool? get isFavoriteFilter => true;

  @override
  bool get isTrashedFilter => false;
}

final favoritesProvider =
    AsyncNotifierProvider<FavoritesNotifier, MediaCollectionState>(
        FavoritesNotifier.new);