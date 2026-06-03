import 'package:echo_frame/database/daos/media_dao.dart';
import 'package:echo_frame/database/database.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SearchNotifier extends AsyncNotifier<List<MediaRecord>> {
  @override
  Future<List<MediaRecord>> build() async => [];

  Future<void> search(String query) async {
    final trimmed = query.trim();
    if (trimmed.isEmpty || !EchoDatabase.isOpen) {
      state = const AsyncData([]);
      return;
    }
    state = const AsyncLoading();
    state = await AsyncValue.guard(
      () => MediaDao(EchoDatabase.instance).search(trimmed),
    );
  }

  void clear() => state = const AsyncData([]);
}

final searchProvider = AsyncNotifierProvider<SearchNotifier, List<MediaRecord>>(
    SearchNotifier.new);
