import 'package:echo_frame/views/media/components/photo_tile.dart' show PlaceholderTile;
import 'package:flutter/material.dart';

class MediaListSkeleton extends StatelessWidget {
  const MediaListSkeleton({super.key});

  static const int _tileCount = 40;

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      physics: const NeverScrollableScrollPhysics(),
      slivers: [
        SliverGrid.builder(
          gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: 180,
            crossAxisSpacing: 2,
            mainAxisSpacing: 2,
          ),
          itemCount: _tileCount,
          itemBuilder: (_, __) => const PlaceholderTile(),
        ),
      ],
    );
  }
}