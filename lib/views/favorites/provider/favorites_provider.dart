import 'package:echo_frame/database/daos/media_dao.dart';
import 'package:echo_frame/database/database.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FavoritesNotifier extends AsyncNotifier<List<MediaRecord>> {
  @override
  Future<List<MediaRecord>> build() async {
    if (!EchoDatabase.isOpen) return [];
    return MediaDao(EchoDatabase.instance).listFavorites();
  }

  Future<void> refresh() async {
    if (!EchoDatabase.isOpen) return;
    state = const AsyncLoading();
    state = await AsyncValue.guard(
      () => MediaDao(EchoDatabase.instance).listFavorites(),
    );
  }
}

final favoritesProvider =
    AsyncNotifierProvider<FavoritesNotifier, List<MediaRecord>>(
        FavoritesNotifier.new);
