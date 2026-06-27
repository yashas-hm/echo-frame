import 'package:echo_frame/database/daos/media_dao.dart';
import 'package:echo_frame/database/database.dart';
import 'package:echo_frame/services/trash_service.dart';
import 'package:echo_frame/utilities/utilities.dart' show Prefs;
import 'package:echo_frame/views/media/provider/media_collection_notifier.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

export 'package:echo_frame/views/media/provider/media_collection_notifier.dart'
    show MediaCollectionState;

class TrashNotifier extends MediaCollectionNotifier {
  @override
  MediaCollectionSource get source => MediaCollectionSource.trash;

  Future<bool> emptyAll() async {
    if (!EchoDatabase.isOpen) return false;
    final root = Prefs.activeLibraryRoot;
    if (root == null) return false;
    final success = await TrashService.emptyAll(root);
    if (!success) return false;
    await MediaDao.instance.deleteAllTrashed();
    state = AsyncData(MediaCollectionState.initialize());
    return true;
  }
}

final trashProvider =
    AsyncNotifierProvider<TrashNotifier, MediaCollectionState>(
        TrashNotifier.new);
