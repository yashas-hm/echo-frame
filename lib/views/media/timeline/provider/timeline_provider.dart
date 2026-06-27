part of '../timeline_screen.dart';

class TimelineNotifier extends MediaCollectionNotifier {
  @override
  MediaCollectionSource get source => MediaCollectionSource.timeline;
}

final timelineProvider =
    AsyncNotifierProvider<TimelineNotifier, MediaCollectionState>(
        TimelineNotifier.new);
