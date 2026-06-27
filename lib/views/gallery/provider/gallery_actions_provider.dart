part of '../components/actions_tray.dart';

class GalleryActions {
  const GalleryActions(this._ref);

  final Ref _ref;

  Future<bool> setFavourite(MediaItem item, {required bool value}) async {
    if (!EchoDatabase.isOpen) return false;
    await MediaDao.instance.setFavorite(item.id, value: value);
    _syncAll(item.copyWith(isFavorite: value));
    return true;
  }

  Future<MediaItem?> trash(MediaItem item) async {
    if (!EchoDatabase.isOpen) return null;
    final root = Prefs.activeLibraryRoot!;
    final newPath = await TrashService.trash(item.filePath, root);
    if (newPath == null) return null;
    await MediaDao.instance.setTrashed(
      item.id,
      value: true,
      relativePath: newPath.substring(root.length + 1),
    );
    final trashedItem = item.copyWith(filePath: newPath, isTrashed: true);
    _syncAll(trashedItem);
    return trashedItem;
  }

  Future<bool> restore(MediaItem item, {bool undo = false}) async {
    if (!EchoDatabase.isOpen) return false;
    final root = Prefs.activeLibraryRoot!;
    final newPath = await TrashService.restore(item.filePath, root);
    if (newPath == null) return false;
    await MediaDao.instance.setTrashed(
      item.id,
      value: false,
      relativePath: newPath.substring(root.length + 1),
    );
    if (undo) {
      _syncAll(item.copyWith(filePath: newPath, isTrashed: false));
    } else {
      _ref.invalidate(timelineProvider);
      _ref.invalidate(favoritesProvider);
      _ref.invalidate(trashProvider);
    }
    return true;
  }

  Future<bool> addTag(MediaItem item, Tag tag) async {
    if (!EchoDatabase.isOpen) return false;
    final ok =
        await _ref.read(tagsProvider.notifier).attachToMedia(item.id, tag.id);
    if (!ok) return false;
    _syncAll(item.copyWith(tags: [...item.tags, tag]));
    return true;
  }

  Future<bool> removeTag(MediaItem item, Tag tag) async {
    if (!EchoDatabase.isOpen) return false;
    final ok =
        await _ref.read(tagsProvider.notifier).detachFromMedia(item.id, tag.id);
    if (!ok) return false;
    _syncAll(
        item.copyWith(tags: item.tags.where((t) => t.id != tag.id).toList()));
    return true;
  }

  Future<bool> createAndAddTag(MediaItem item, String value) async {
    if (!EchoDatabase.isOpen) return false;
    final notifier = _ref.read(tagsProvider.notifier);
    final tag = await notifier.createTag(value);
    if (tag == null) return false;
    final ok = await notifier.attachToMedia(item.id, tag.id);
    if (!ok) return false;
    _syncAll(item.copyWith(tags: [...item.tags, tag]));
    return true;
  }

  Future<bool> permanentDelete(MediaItem item) async {
    if (!EchoDatabase.isOpen) return false;
    final success = await TrashService.permanentDelete(item.filePath);
    if (!success) return false;
    await MediaDao.instance.permanentDelete(item.id);
    _ref.read(trashProvider.notifier).syncItem(item.copyWith(isTrashed: false));
    return true;
  }

  void _syncAll(MediaItem updated) {
    _ref.read(timelineProvider.notifier).syncItem(updated);
    _ref.read(favoritesProvider.notifier).syncItem(updated);
    _ref.read(trashProvider.notifier).syncItem(updated);
  }
}

final galleryActionsProvider = Provider<GalleryActions>(GalleryActions.new);
