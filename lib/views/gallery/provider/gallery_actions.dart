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

  Future<void> setFavourite(String id, {required bool value}) async {
    if (!EchoDatabase.isOpen) return;
    await MediaDao.instance.setFavorite(id, value: value);
    _ref.read(timelineProvider.notifier).syncItem(id, isFavorite: value);
    _ref.read(favoritesProvider.notifier).syncItem(id, isFavorite: value);
  }

  Future<void> trash(MediaItem item) async {
    if (!EchoDatabase.isOpen) return;
    final root = Prefs.activeLibraryRoot!;
    final newPath = await TrashService.trash(item.filePath, root);
    if (newPath == null) return;
    await MediaDao.instance.setTrashed(
      item.id,
      value: true,
      relativePath: newPath.substring(root.length + 1),
    );
    _ref.read(timelineProvider.notifier).syncItem(item.id, isTrashed: true);
    _ref.read(favoritesProvider.notifier).syncItem(item.id, isTrashed: true);
  }

  Future<void> restore(MediaItem item) async {
    if (!EchoDatabase.isOpen) return;
    final root = Prefs.activeLibraryRoot!;
    final newPath = await TrashService.restore(item.filePath, root);
    if (newPath == null) return;
    await MediaDao.instance.setTrashed(
      item.id,
      value: false,
      relativePath: newPath.substring(root.length + 1),
    );
    _ref.invalidate(timelineProvider);
    _ref.invalidate(favoritesProvider);
  }

  Future<void> permanentDelete(MediaItem item) async {
    if (!EchoDatabase.isOpen) return;
    await TrashService.permanentDelete(item.filePath);
    await MediaDao.instance.permanentDelete(item.id);
  }
}

final galleryActionsProvider = Provider<GalleryActions>(GalleryActions.new);
