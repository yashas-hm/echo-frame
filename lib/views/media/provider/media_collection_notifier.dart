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
  Future<MediaCollectionState> build() => _fetch(offset: 0, query: '');

  Future<void> loadNextPage() async {
    final current = state.value;
    if (current == null || !current.hasMore || current.isLoadingMore) return;
    state = AsyncData(current.copyWith(isLoadingMore: true));
    final items = await MediaDao.instance.queryPage(
      offset: current.loaded.length,
      limit: _pageSize,
      query: current.query.isEmpty ? null : current.query,
      isFavorite: isFavoriteFilter,
      isTrashed: isTrashedFilter,
    );
    state = AsyncData(current.copyWith(
      loaded: [...current.loaded, ...items],
      hasMore: items.length == _pageSize,
      isLoadingMore: false,
    ));
  }

  void syncItem(MediaItem item) {
    final current = state.value;
    if (current == null) return;
    final idx = current.loaded.indexWhere((e) => e.id == item.id);

    final shouldRemove =
        (item.isFavorite == false && isFavoriteFilter == true) ||
            (item.isTrashed == true && isTrashedFilter == false) ||
            (item.isTrashed == false && isTrashedFilter == true);

    if (idx == -1 && shouldRemove) return;

    final updated = List<MediaItem>.of(current.loaded);
    if (idx == -1) {
      final insertAt = updated.indexWhere(
        (e) => e.capturedAt.isBefore(item.capturedAt),
      );
      if (insertAt == -1) {
        updated.add(item);
      } else {
        updated.insert(insertAt, item);
      }
    } else if (shouldRemove) {
      updated.removeAt(idx);
    } else {
      updated[idx] = item;
    }
    state = AsyncData(current.copyWith(loaded: updated));
  }

  Future<void> setQuery(String query) async {
    state = const AsyncLoading();
    state = AsyncData(await _fetch(offset: 0, query: query));
  }

  Future<MediaCollectionState> _fetch({
    required int offset,
    required String query,
  }) async {
    if (!EchoDatabase.isOpen) {
      return const MediaCollectionState(loaded: [], hasMore: false);
    }
    final items = await MediaDao.instance.queryPage(
      offset: offset,
      limit: _pageSize,
      query: query.isEmpty ? null : query,
      isFavorite: isFavoriteFilter,
      isTrashed: isTrashedFilter,
    );
    return MediaCollectionState(
      loaded: items,
      hasMore: items.length == _pageSize,
      query: query,
    );
  }
}
