import 'package:echo_frame/database/daos/media_dao.dart';
import 'package:echo_frame/database/database.dart';
import 'package:echo_frame/models/media_item.dart';
import 'package:echo_frame/models/month_data.dart';
import 'package:echo_frame/views/favorites/provider/favorites_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TimelineState {
  final List<MediaItem> loaded;
  final bool hasMore;
  final bool isLoadingMore;
  final String query;

  const TimelineState({
    required this.loaded,
    required this.hasMore,
    this.isLoadingMore = false,
    this.query = '',
  });

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

  TimelineState copyWith({
    List<MediaItem>? loaded,
    bool? hasMore,
    bool? isLoadingMore,
    String? query,
  }) =>
      TimelineState(
        loaded: loaded ?? this.loaded,
        hasMore: hasMore ?? this.hasMore,
        isLoadingMore: isLoadingMore ?? this.isLoadingMore,
        query: query ?? this.query,
      );
}

class TimelineNotifier extends AsyncNotifier<TimelineState> {
  static const _pageSize = 100;

  @override
  Future<TimelineState> build() => _fetch(offset: 0, query: '');

  Future<void> loadNextPage() async {
    final current = state.value;
    if (current == null || !current.hasMore || current.isLoadingMore) return;
    state = AsyncData(current.copyWith(isLoadingMore: true));
    final items = await MediaDao.instance.queryPage(
      offset: current.loaded.length,
      limit: _pageSize,
      query: current.query.isEmpty ? null : current.query,
    );
    state = AsyncData(current.copyWith(
      loaded: [...current.loaded, ...items],
      hasMore: items.length == _pageSize,
      isLoadingMore: false,
    ));
  }

  Future<void> setFavourite(String id, {required bool value}) async {
    final current = state.value;
    if (current == null || !EchoDatabase.isOpen) return;
    final idx = current.loaded.indexWhere((e) => e.id == id);
    if (idx == -1) return;
    final updated = List<MediaItem>.of(current.loaded);
    updated[idx] = current.loaded[idx].setFavourite(value);
    state = AsyncData(current.copyWith(loaded: updated));
    await MediaDao.instance.setFavorite(id, value: value);
    ref
        .read(favoritesProvider.notifier)
        .setFavourite(updated[idx], value: value);
  }

  Future<void> setQuery(String query) async {
    state = const AsyncLoading();
    state = AsyncData(await _fetch(offset: 0, query: query));
  }

  Future<TimelineState> _fetch({
    required int offset,
    required String query,
  }) async {
    if (!EchoDatabase.isOpen) {
      return const TimelineState(loaded: [], hasMore: false);
    }
    final items = await MediaDao.instance.queryPage(
      offset: offset,
      limit: _pageSize,
      query: query.isEmpty ? null : query,
    );
    return TimelineState(
      loaded: items,
      hasMore: items.length == _pageSize,
      query: query,
    );
  }
}

final timelineProvider = AsyncNotifierProvider<TimelineNotifier, TimelineState>(
  TimelineNotifier.new,
);
