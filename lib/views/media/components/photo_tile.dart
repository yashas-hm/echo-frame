import 'dart:io';

import 'package:echo_frame/models/media/media.dart' show MediaItem;
import 'package:echo_frame/theme/theme.dart';
import 'package:echo_frame/utilities/utilities.dart'
    show ContextExtensions, ColorExtensions;
import 'package:echo_frame/views/gallery/gallery_screen.dart';
import 'package:echo_frame/views/media/provider/media_collection_notifier.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shimmer/shimmer.dart';

class PlaceholderTile extends StatelessWidget {
  const PlaceholderTile({super.key});

  @override
  Widget build(BuildContext context) {
    final highlight = context.colors.borderPrimary;
    return Shimmer.fromColors(
      baseColor: highlight.hover,
      highlightColor: highlight.splash,
      child: ColoredBox(color: context.colors.surfacePrimary),
    );
  }
}

class PhotoTile extends StatelessWidget {
  const PhotoTile({super.key, required this.item, required this.source});

  final MediaItem item;
  final MediaCollectionSource source;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => context.push(
        GalleryScreen.path,
        extra: (item.id, source),
      ),
      child: SizedBox.expand(
        child: item.isVideo
            ? _videoTile(context.colors)
            : _imageTile(context.colors),
      ),
    );
  }

  Widget _imageTile(AppThemeColors colors) => Hero(
        tag: item.id,
        child: Image.file(
          File(item.filePath),
          cacheWidth:
              item.width == null ? 180 : (item.width! ~/ 10).clamp(1, 9999),
          cacheHeight:
              item.height == null ? 180 : (item.height! ~/ 10).clamp(1, 9999),
          fit: BoxFit.cover,
          frameBuilder: (_, child, frame, wasSynchronouslyLoaded) =>
              wasSynchronouslyLoaded || frame != null
                  ? child
                  : const PlaceholderTile(),
          errorBuilder: (_, err, ___) => _placeholder(colors),
        ),
      );

  Widget _videoTile(AppThemeColors colors) {
    final thumb = item.thumbnailPath;
    return Stack(
      fit: StackFit.expand,
      children: [
        if (thumb != null)
          Hero(
            tag: item.id,
            child: Image.file(
              File(thumb),
              frameBuilder: (_, child, frame, wasSynchronouslyLoaded) =>
                  wasSynchronouslyLoaded || frame != null
                      ? child
                      : const PlaceholderTile(),
              fit: BoxFit.cover,
            ),
          )
        else
          _placeholder(
            colors,
            icon: Icons.videocam_outlined,
          ),
        Align(
          alignment: Alignment.bottomRight,
          child: Padding(
            padding: EdgeInsets.all(4),
            child: DecoratedBox(
              decoration: BoxDecoration(
                color: KnownColors.slate800.withValues(alpha: 0.5),
                borderRadius: BorderRadius.all(Radius.circular(4)),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                child: Icon(
                  Icons.play_arrow_rounded,
                  color: colors.onPrimary,
                  size: 14,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _placeholder(
    AppThemeColors colors, {
    IconData icon = Icons.hide_image_outlined,
  }) =>
      ColoredBox(
        color: colors.surfacePrimary,
        child: Icon(icon, color: colors.textSecondary),
      );
}
