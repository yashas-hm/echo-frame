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
    required Map<String, MediaItem> items,
    required this.hasMore,
    this.isLoadingMore = false,
    this.query = '',
  }) : _items = items {
    flatItems = _items.values.toList()
      ..sort((a, b) => b.capturedAt.compareTo(a.capturedAt));
  }

  MediaCollectionState._presorted({
    required Map<String, MediaItem> items,
    required List<MediaItem> sorted,
    required this.hasMore,
    required this.isLoadingMore,
    required this.query,
  })  : _items = items,
        flatItems = sorted;

  late final List<MediaItem> flatItems;
  final Map<String, MediaItem> _items;
  final bool hasMore;
  final bool isLoadingMore;
  final String query;

  late final List<MonthData> byMonth = _buildByMonth();

  List<MonthData> _buildByMonth() {
    final map = <(int, int), List<MediaItem>>{};
    for (final item in flatItems) {
      final key = (item.capturedAt.year, item.capturedAt.month);
      (map[key] ??= []).add(item);
    }
    return map.entries
        .map((e) => MonthData(year: e.key.$1, month: e.key.$2, items: e.value))
        .toList();
  }

  factory MediaCollectionState.initialize() =>
      MediaCollectionState(items: {}, hasMore: true);

  MediaCollectionState copyWith({
    Map<String, MediaItem>? items,
    bool? hasMore,
    bool? isLoadingMore,
    String? query,
  }) {
    if (items == null) {
      return MediaCollectionState._presorted(
        items: _items,
        sorted: flatItems,
        hasMore: hasMore ?? this.hasMore,
        isLoadingMore: isLoadingMore ?? this.isLoadingMore,
        query: query ?? this.query,
      );
    }
    return MediaCollectionState(
      items: items,
      hasMore: hasMore ?? this.hasMore,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
      query: query ?? this.query,
    );
  }
}
