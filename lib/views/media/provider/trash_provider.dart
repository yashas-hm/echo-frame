import 'package:echo_frame/views/media/provider/media_collection_notifier.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

export 'package:echo_frame/views/media/provider/media_collection_notifier.dart'
    show MediaCollectionState;

class TrashNotifier extends MediaCollectionNotifier {
  @override
  MediaCollectionSource get source => MediaCollectionSource.trash;
}

final trashProvider =
    AsyncNotifierProvider<TrashNotifier, MediaCollectionState>(
        TrashNotifier.new);