import 'package:echo_frame/database/daos/media_dao.dart';
import 'package:echo_frame/database/database.dart';
import 'package:echo_frame/models/media_item.dart';
import 'package:echo_frame/services/trash_service.dart';
import 'package:echo_frame/utilities/utilities.dart' show Prefs;
import 'package:echo_frame/views/favorites/provider/favorites_provider.dart';
import 'package:echo_frame/views/timeline/provider/timeline_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class GalleryActions {
  const GalleryActions(this._ref);

  final Ref _ref;

  Future<bool> setFavourite(String id, {required bool value}) async {
    if (!EchoDatabase.isOpen) return false;
    await MediaDao.instance.setFavorite(id, value: value);
    _ref.read(timelineProvider.notifier).syncItem(id, isFavorite: value);
    _ref.read(favoritesProvider.notifier).syncItem(id, isFavorite: value);
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
    _ref.read(timelineProvider.notifier).syncItem(item.id, isTrashed: true);
    _ref.read(favoritesProvider.notifier).syncItem(item.id, isTrashed: true);
    return item.copyWith(filePath: newPath, isTrashed: true);
  }

  Future<bool> restore(MediaItem item) async {
    if (!EchoDatabase.isOpen) return false;
    final root = Prefs.activeLibraryRoot!;
    final newPath = await TrashService.restore(item.filePath, root);
    if (newPath == null) return false;
    await MediaDao.instance.setTrashed(
      item.id,
      value: false,
      relativePath: newPath.substring(root.length + 1),
    );
    _ref.invalidate(timelineProvider);
    _ref.invalidate(favoritesProvider);
    return true;
  }

  Future<bool> permanentDelete(MediaItem item) async {
    if (!EchoDatabase.isOpen) return false;
    final success = await TrashService.permanentDelete(item.filePath);
    if(!success) return false;
    await MediaDao.instance.permanentDelete(item.id);
    return true;
  }
}

final galleryActionsProvider = Provider<GalleryActions>(GalleryActions.new);
