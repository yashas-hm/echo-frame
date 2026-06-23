import 'package:echo_frame/database/daos/media_dao.dart';
import 'package:echo_frame/database/database.dart';
import 'package:echo_frame/models/media_item.dart';
import 'package:echo_frame/services/trash_service.dart';
import 'package:echo_frame/utilities/utilities.dart' show Prefs;
import 'package:echo_frame/views/media/provider/favorites_provider.dart';
import 'package:echo_frame/views/media/provider/timeline_provider.dart';
import 'package:echo_frame/views/media/provider/trash_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class GalleryActions {
  const GalleryActions(this._ref);

  final Ref _ref;

  Future<bool> setFavourite(MediaItem item, {required bool value}) async {
    if (!EchoDatabase.isOpen) return false;
    await MediaDao.instance.setFavorite(item.id, value: value);
    final updated = item.copyWith(isFavorite: value);
    _ref.read(timelineProvider.notifier).syncItem(updated);
    _ref.read(favoritesProvider.notifier).syncItem(updated);
    _ref.read(trashProvider.notifier).syncItem(updated);
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
    _ref.read(timelineProvider.notifier).syncItem(trashedItem);
    _ref.read(favoritesProvider.notifier).syncItem(trashedItem);
    _ref.read(trashProvider.notifier).syncItem(trashedItem);
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
      final restoredItem = item.copyWith(filePath: newPath, isTrashed: false);
      _ref.read(timelineProvider.notifier).syncItem(restoredItem);
      _ref.read(favoritesProvider.notifier).syncItem(restoredItem);
      _ref.read(trashProvider.notifier).syncItem(restoredItem);
    } else {
      _ref.invalidate(timelineProvider);
      _ref.invalidate(favoritesProvider);
      _ref.invalidate(trashProvider);
    }
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
}

final galleryActionsProvider = Provider<GalleryActions>(GalleryActions.new);
