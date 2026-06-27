part of '../components/gallery_info_panel.dart';

class TagsNotifier extends AsyncNotifier<List<Tag>> {
  @override
  Future<List<Tag>> build() => TagDao.instance.listAll();

  Future<Tag?> createTag(String value) async {
    try {
      final tag = await TagDao.instance.createTag(value);
      state = AsyncData([...state.value ?? [], tag]);
      return tag;
    } catch (e, st) {
      dev.log('failed to create tag: $e', stackTrace: st, name: 'TagsNotifier.createTag');
      return null;
    }
  }

  Future<bool> attachToMedia(String mediaId, String tagId) async {
    try {
      await TagDao.instance.attachTag(mediaId, tagId);
      return true;
    } catch (e, st) {
      dev.log('failed to attach tag: $e', stackTrace: st, name: 'TagsNotifier.attachToMedia');
      return false;
    }
  }

  Future<bool> detachFromMedia(String mediaId, String tagId) async {
    try {
      await TagDao.instance.detachTag(mediaId, tagId);
      return true;
    } catch (e, st) {
      dev.log('failed to detach tag: $e', stackTrace: st, name: 'TagsNotifier.detachFromMedia');
      return false;
    }
  }
}

final tagsProvider =
    AsyncNotifierProvider<TagsNotifier, List<Tag>>(TagsNotifier.new);