import 'package:echo_frame/database/daos/media_dao.dart';
import 'package:echo_frame/database/database.dart';
import 'package:echo_frame/models/media_item.dart';
import 'package:echo_frame/models/timeline/timeline_models.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MonthData {
  final int year;
  final int month;
  final List<MediaItem> items;

  const MonthData(
      {required this.year, required this.month, required this.items});

  String get monthName => MonthFolder.monthNames[month - 1];
}

class TimelineState {
  final List<({int year, int month, int count})> allMonths;
  final List<MonthData> loaded;
  final bool hasMore;

  const TimelineState({
    required this.allMonths,
    required this.loaded,
    required this.hasMore,
  });

  List<MediaItem> get flatItems =>
      loaded.expand((m) => m.items).toList(growable: false);

  TimelineState copyWith({
    List<({int year, int month, int count})>? allMonths,
    List<MonthData>? loaded,
    bool? hasMore,
  }) =>
      TimelineState(
        allMonths: allMonths ?? this.allMonths,
        loaded: loaded ?? this.loaded,
        hasMore: hasMore ?? this.hasMore,
      );
}

class TimelineNotifier extends AsyncNotifier<TimelineState> {
  static const _pageSize = 3;

  @override
  Future<TimelineState> build() async {
    if (!EchoDatabase.isOpen) {
      return const TimelineState(allMonths: [], loaded: [], hasMore: false);
    }
    final allMonths = await MediaDao(EchoDatabase.instance).listMonths();
    if (allMonths.isEmpty) {
      return const TimelineState(allMonths: [], loaded: [], hasMore: false);
    }
    final firstPage = await _loadPage(allMonths.take(_pageSize).toList());
    return TimelineState(
      allMonths: allMonths,
      loaded: firstPage,
      hasMore: allMonths.length > _pageSize,
    );
  }

  Future<void> loadNextPage() async {
    final current = state.value;
    if (current == null || !current.hasMore) return;

    final nextMonths =
        current.allMonths.skip(current.loaded.length).take(_pageSize).toList();
    if (nextMonths.isEmpty) return;

    final loaded = await _loadPage(nextMonths);
    state = AsyncData(current.copyWith(
      loaded: [...current.loaded, ...loaded],
      hasMore: current.loaded.length + loaded.length < current.allMonths.length,
    ));
  }

  Future<List<MonthData>> _loadPage(
          List<({int year, int month, int count})> months) =>
      Future.wait(months.map((s) async {
        final records =
            await MediaDao(EchoDatabase.instance).queryByMonth(s.year, s.month);
        return MonthData(
          year: s.year,
          month: s.month,
          items: records.map(MediaItem.fromRecord).toList(),
        );
      }));
}

final timelineProvider = AsyncNotifierProvider<TimelineNotifier, TimelineState>(
  TimelineNotifier.new,
);
