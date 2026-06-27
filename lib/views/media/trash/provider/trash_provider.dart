part of '../trash_screen.dart';

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
