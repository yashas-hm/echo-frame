import 'package:echo_frame/views/media/provider/media_collection_notifier.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

export 'package:echo_frame/views/media/provider/media_collection_notifier.dart'
    show MediaCollectionState;

class TimelineNotifier extends MediaCollectionNotifier {
  @override
  MediaCollectionSource get source => MediaCollectionSource.timeline;
}

final timelineProvider =
    AsyncNotifierProvider<TimelineNotifier, MediaCollectionState>(
        TimelineNotifier.new);
