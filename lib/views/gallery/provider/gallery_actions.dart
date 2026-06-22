import 'package:echo_frame/database/daos/media_dao.dart';
import 'package:echo_frame/database/database.dart';
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

  // Removes from timeline and favorites in-place; trash provider updated separately.
  Future<void> trash(String id) async {
    if (!EchoDatabase.isOpen) return;
    await MediaDao.instance.setTrashed(id, value: true);
    _ref.read(timelineProvider.notifier).syncItem(id, isTrashed: true);
    _ref.read(favoritesProvider.notifier).syncItem(id, isTrashed: true);
  }

  // Removes from trash in-place; timeline and favorites reload when navigated to.
  Future<void> restore(String id) async {
    if (!EchoDatabase.isOpen) return;
    await MediaDao.instance.setTrashed(id, value: false);
    _ref.invalidate(timelineProvider);
    _ref.invalidate(favoritesProvider);
  }
}

final galleryActionsProvider = Provider<GalleryActions>(GalleryActions.new);