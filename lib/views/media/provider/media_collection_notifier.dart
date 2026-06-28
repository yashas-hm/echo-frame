import 'package:echo_frame/database/daos/media_dao.dart';
import 'package:echo_frame/database/database.dart';
import 'package:echo_frame/models/media/media.dart' show MediaItem;
import 'package:echo_frame/models/month_count.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

part 'media_collection_state.dart';

const _pageSize = 100;

abstract class MediaCollectionNotifier
    extends AsyncNotifier<MediaCollectionState> {
  static const _windowSize = 20;

  MediaCollectionSource get source;

  bool? get isFavoriteFilter => source.isFavoriteFilter;

  bool get isTrashedFilter => source.isTrashedFilter;

  // Two-phase startup: emit placeholder skeleton immediately, then load page 0.
  @override
  Future<MediaCollectionState> build() async {
    final counts = await _queryMonthCounts();
    final skeleton = MediaCollectionState.initialize(monthCounts: counts);
    if (counts.isEmpty) return skeleton;
    state = AsyncData(skeleton); // phase 1: placeholder grid visible
    return _loadBottomPage(skeleton); // phase 2: first real tiles fill in
  }

  Future<MediaCollectionState> loadNextPage([MediaCollectionState? base]) async {
    final current = base ?? state.value;
    if (current == null || !current.hasMoreBottom || current.isLoadingMore) {
      return current ?? MediaCollectionState.initialize();
    }
    if (base == null) state = AsyncData(current.copyWith(isLoadingMore: true));

    final nextPage = current.lastPageIndex + 1;
    final items = await _queryPage(offset: nextPage * _pageSize, query: current.query);
    final newPages = Map<int, List<MediaItem>>.of(current._pages)..[nextPage] = items;
    var newFirst = current.firstPageIndex;
    if (newPages.length > _windowSize) {
      newPages.remove(newFirst);
      newFirst++;
    }

    final next = current.copyWith(
      pages: newPages,
      firstPageIndex: newFirst,
      lastPageIndex: nextPage,
      hasMoreBottom: items.length == _pageSize,
      isLoadingMore: false,
    );
    if (base == null) state = AsyncData(next);
    return next;
  }

  Future<void> loadPreviousPage() async {
    final current = state.value;
    if (current == null || !current.hasMoreTop || current.isLoadingTop) return;
    state = AsyncData(current.copyWith(isLoadingTop: true));

    final prevPage = current.firstPageIndex - 1;
    final items = await _queryPage(offset: prevPage * _pageSize, query: current.query);
    final newPages = Map<int, List<MediaItem>>.of(current._pages)..[prevPage] = items;
    var newLast = current.lastPageIndex;
    var hasMoreBottom = current.hasMoreBottom;
    if (newPages.length > _windowSize) {
      newPages.remove(newLast);
      newLast--;
      hasMoreBottom = true;
    }

    state = AsyncData(current.copyWith(
      pages: newPages,
      firstPageIndex: prevPage,
      lastPageIndex: newLast,
      hasMoreBottom: hasMoreBottom,
      isLoadingTop: false,
    ));
  }

  // isJumping is independent of isLoadingMore so scroll loads are never blocked
  // by a scrubber jump.
  Future<void> jumpToPage(int targetPageIndex) async {
    final current = state.value;
    if (current == null || current.isJumping) return;
    state = AsyncData(current.copyWith(isJumping: true));

    final first = (targetPageIndex - 2).clamp(0, targetPageIndex);
    final last = targetPageIndex + 2;
    final results = await Future.wait([
      for (var p = first; p <= last; p++)
        _queryPage(offset: p * _pageSize, query: current.query),
    ]);
    final newPages = {for (var i = 0; i < results.length; i++) first + i: results[i]};

    state = AsyncData(current.copyWith(
      pages: newPages,
      firstPageIndex: first,
      lastPageIndex: last,
      hasMoreBottom: results.last.length == _pageSize,
      isJumping: false,
    ));
  }

  // Skeleton-first: emit updated month counts immediately so the grid
  // restructures without any loading flash, then fill page 0.
  Future<void> setQuery(String query) async {
    final counts = await _queryMonthCounts(query: query.isEmpty ? null : query);
    final skeleton = MediaCollectionState.initialize(monthCounts: counts, query: query);
    state = AsyncData(skeleton);
    if (counts.isNotEmpty) state = AsyncData(await _loadBottomPage(skeleton));
  }

  void syncItem(MediaItem item) {
    final current = state.value;
    if (current == null) return;
    final pos = current._idIndex[item.id];
    if (pos == null) return; // item in evicted page — no-op

    final (pageIndex, indexInPage) = pos;
    final shouldRemove = (item.isFavorite == false && isFavoriteFilter == true) ||
        (item.isTrashed == true && isTrashedFilter == false) ||
        (item.isTrashed == false && isTrashedFilter == true);

    final updatedPage = List.of(current._pages[pageIndex]!);
    if (shouldRemove) {
      updatedPage.removeAt(indexInPage);
    } else {
      updatedPage[indexInPage] = item;
    }
    final newPages = Map<int, List<MediaItem>>.of(current._pages)..[pageIndex] = updatedPage;
    state = AsyncData(current.copyWith(pages: newPages));
  }

  Future<MediaCollectionState> _loadBottomPage(MediaCollectionState base) async {
    final items = await _queryPage(offset: 0, query: base.query);
    return base.copyWith(
      pages: {0: items},
      firstPageIndex: 0,
      lastPageIndex: 0,
      hasMoreBottom: items.length == _pageSize,
    );
  }

  Future<List<MonthCount>> _queryMonthCounts({String? query}) {
    if (!EchoDatabase.isOpen) return Future.value([]);
    return MediaDao.instance.queryMonthCounts(
      isFavorite: isFavoriteFilter,
      isTrashed: isTrashedFilter,
      query: query,
    );
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
