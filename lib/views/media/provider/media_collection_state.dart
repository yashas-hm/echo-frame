part of 'media_collection_notifier.dart';

class MediaCollectionState {
  const MediaCollectionState({
    required this.loaded,
    required this.hasMore,
    this.isLoadingMore = false,
    this.query = '',
  });

  final List<MediaItem> loaded;
  final bool hasMore;
  final bool isLoadingMore;
  final String query;

  List<MediaItem> get flatItems => loaded;

  List<MonthData> get byMonth {
    final map = <(int, int), List<MediaItem>>{};
    for (final item in loaded) {
      final key = (item.capturedAt.year, item.capturedAt.month);
      (map[key] ??= []).add(item);
    }
    return map.entries
        .map((e) => MonthData(year: e.key.$1, month: e.key.$2, items: e.value))
        .toList();
  }

  MediaCollectionState copyWith({
    List<MediaItem>? loaded,
    bool? hasMore,
    bool? isLoadingMore,
    String? query,
  }) =>
      MediaCollectionState(
        loaded: loaded ?? this.loaded,
        hasMore: hasMore ?? this.hasMore,
        isLoadingMore: isLoadingMore ?? this.isLoadingMore,
        query: query ?? this.query,
      );
}
