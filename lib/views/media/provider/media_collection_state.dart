part of 'media_collection_notifier.dart';

enum MediaCollectionSource {
  timeline,
  favorites,
  trash;

  bool? get isFavoriteFilter => switch (this) {
        favorites => true,
        _ => null,
      };

  bool get isTrashedFilter => this == trash;
}

class MediaCollectionState {
  MediaCollectionState({
    required this.monthCounts,
    required Map<int, List<MediaItem>> pages,
    required this.firstPageIndex,
    required this.lastPageIndex,
    required this.hasMoreBottom,
    this.isLoadingMore = false,
    this.isLoadingTop = false,
    this.isJumping = false,
    this.query = '',
  }) : _pages = pages {
    flatItems = [
      for (var i = firstPageIndex; i <= lastPageIndex; i++) ...(_pages[i] ?? []),
    ];
    _idIndex = {
      for (final entry in pages.entries)
        for (var i = 0; i < entry.value.length; i++)
          entry.value[i].id: (entry.key, i),
    };
  }

  MediaCollectionState._presorted({
    required this.monthCounts,
    required Map<int, List<MediaItem>> pages,
    required List<MediaItem> sorted,
    required Map<String, (int, int)> idIndex,
    required this.firstPageIndex,
    required this.lastPageIndex,
    required this.hasMoreBottom,
    required this.isLoadingMore,
    required this.isLoadingTop,
    required this.isJumping,
    required this.query,
  })  : _pages = pages,
        flatItems = sorted,
        _idIndex = idIndex;

  final List<MonthCount> monthCounts;
  final Map<int, List<MediaItem>> _pages;
  late final Map<String, (int, int)> _idIndex; // ID → (pageIndex, indexInPage)
  final int firstPageIndex;
  final int lastPageIndex;
  final bool hasMoreBottom;
  final bool isLoadingMore;
  final bool isLoadingTop;
  final bool isJumping;
  final String query;

  late final List<MediaItem> flatItems; // windowed items for gallery screen

  int get totalCount => monthCounts.fold(0, (s, m) => s + m.count);
  bool get hasMoreTop => firstPageIndex > 0;
  int get evictedTopCount => firstPageIndex * _pageSize;

  // O(1) item lookup by absolute global index — used by grid itemBuilder
  MediaItem? itemAt(int globalIndex) {
    final pageIndex = globalIndex ~/ _pageSize;
    final indexInPage = globalIndex % _pageSize;
    final page = _pages[pageIndex];
    if (page == null || indexInPage >= page.length) return null;
    return page[indexInPage];
  }

  factory MediaCollectionState.initialize({
    List<MonthCount> monthCounts = const [],
    String query = '',
  }) =>
      MediaCollectionState(
        monthCounts: monthCounts,
        pages: const {},
        firstPageIndex: 0,
        lastPageIndex: -1,
        hasMoreBottom: monthCounts.isNotEmpty,
        query: query,
      );

  MediaCollectionState copyWith({
    List<MonthCount>? monthCounts,
    Map<int, List<MediaItem>>? pages,
    int? firstPageIndex,
    int? lastPageIndex,
    bool? hasMoreBottom,
    bool? isLoadingMore,
    bool? isLoadingTop,
    bool? isJumping,
    String? query,
  }) {
    // Fast path: page data unchanged — reuse flatItems + _idIndex, skip re-concat
    if (pages == null && monthCounts == null) {
      return MediaCollectionState._presorted(
        monthCounts: this.monthCounts,
        pages: _pages,
        sorted: flatItems,
        idIndex: _idIndex,
        firstPageIndex: firstPageIndex ?? this.firstPageIndex,
        lastPageIndex: lastPageIndex ?? this.lastPageIndex,
        hasMoreBottom: hasMoreBottom ?? this.hasMoreBottom,
        isLoadingMore: isLoadingMore ?? this.isLoadingMore,
        isLoadingTop: isLoadingTop ?? this.isLoadingTop,
        isJumping: isJumping ?? this.isJumping,
        query: query ?? this.query,
      );
    }
    return MediaCollectionState(
      monthCounts: monthCounts ?? this.monthCounts,
      pages: pages ?? _pages,
      firstPageIndex: firstPageIndex ?? this.firstPageIndex,
      lastPageIndex: lastPageIndex ?? this.lastPageIndex,
      hasMoreBottom: hasMoreBottom ?? this.hasMoreBottom,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
      isLoadingTop: isLoadingTop ?? this.isLoadingTop,
      isJumping: isJumping ?? this.isJumping,
      query: query ?? this.query,
    );
  }
}
