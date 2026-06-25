import 'package:echo_frame/database/daos/media_dao.dart';
import 'package:echo_frame/database/database.dart';
import 'package:echo_frame/models/media_item.dart';
import 'package:echo_frame/models/month_data.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

part 'media_collection_state.dart';

abstract class MediaCollectionNotifier
    extends AsyncNotifier<MediaCollectionState> {
  static const _pageSize = 100;

  MediaCollectionSource get source;

  bool? get isFavoriteFilter => source.isFavoriteFilter;

  bool get isTrashedFilter => source.isTrashedFilter;

  @override
  Future<MediaCollectionState> build() =>
      loadNextPage(MediaCollectionState.initialize());

  Future<MediaCollectionState> loadNextPage(
      [MediaCollectionState? base]) async {
    final current = base ?? state.value;
    if (current == null || !current.hasMore || current.isLoadingMore) {
      return current ?? MediaCollectionState.initialize();
    }
    if (base == null) state = AsyncData(current.copyWith(isLoadingMore: true));
    final items = await _queryPage(
      offset: current.flatItems.length,
      query: current.query,
    );
    final next = current.copyWith(
      items: {...current._items, for (final item in items) item.id: item},
      hasMore: items.length == _pageSize,
      isLoadingMore: false,
    );
    if (base == null) state = AsyncData(next);
    return next;
  }

  void syncItem(MediaItem item) {
    final current = state.value;
    if (current == null) return;

    final exists = current._items.containsKey(item.id);
    final shouldRemove =
        (item.isFavorite == false && isFavoriteFilter == true) ||
            (item.isTrashed == true && isTrashedFilter == false) ||
            (item.isTrashed == false && isTrashedFilter == true);

    if (!exists && shouldRemove) return;

    final updated = Map<String, MediaItem>.of(current._items);
    if (shouldRemove) {
      updated.remove(item.id);
    } else {
      updated[item.id] = item;
    }
    state = AsyncData(current.copyWith(items: updated));
  }

  Future<void> setQuery(String query) async {
    state = const AsyncLoading();
    final next = await loadNextPage(
      MediaCollectionState(
        items: const {},
        hasMore: true,
        query: query,
      ),
    );
    state = AsyncData(next);
  }

  Future<List<MediaItem>> _queryPage({
    required int offset,
    required String query,
  }) {
    if (!EchoDatabase.isOpen) return Future.value([]);
    return MediaDao.instance.queryPage(
      offset: offset,
      limit: _pageSize,
      query: query.isEmpty ? null : query,
      isFavorite: isFavoriteFilter,
      isTrashed: isTrashedFilter,
    );
  }
}
