import 'package:echo_frame/database/daos/media_dao.dart';
import 'package:echo_frame/database/database.dart';
import 'package:echo_frame/models/media_item.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FavoritesNotifier extends AsyncNotifier<List<MediaItem>> {
  @override
  Future<List<MediaItem>> build() => _load();

  Future<void> refresh() async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(_load);
  }

  Future<List<MediaItem>> _load() async {
    if (!EchoDatabase.isOpen) return [];
    return MediaDao.instance.listFavorites();
  }
}

final favoritesProvider =
    AsyncNotifierProvider<FavoritesNotifier, List<MediaItem>>(
        FavoritesNotifier.new);
