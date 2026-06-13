import 'dart:io';

import 'package:echo_frame/models/media_item.dart';
import 'package:echo_frame/theme/theme.dart';
import 'package:echo_frame/views/gallery/image_screen.dart';
import 'package:echo_frame/views/gallery/video_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class PhotoTile extends StatelessWidget {
  const PhotoTile({super.key, required this.item});

  final MediaItem item;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => context.push(
        item.isVideo ? VideoScreen.route(item.id) : ImageScreen.route(item.id),
      ),
      child: SizedBox.expand(
        child: item.isVideo
            ? _videoTile(context.colors)
            : _imageTile(context.colors),
      ),
    );
  }

  Widget _imageTile(AppThemeColors colors) => Image.file(
        File(item.filePath),
        cacheWidth: item.width == null ? 180 : item.width! ~/ 10,
        cacheHeight: item.height == null ? 180 : item.height! ~/ 10,
        fit: BoxFit.cover,
        errorBuilder: (_, __, ___) => _placeholder(colors),
      );

  Widget _videoTile(AppThemeColors colors) {
    final thumb = item.thumbnailPath;
    return Stack(
      fit: StackFit.expand,
      children: [
        if (thumb != null)
          Image.file(File(thumb), fit: BoxFit.cover)
        else
          _placeholder(colors, icon: Icons.videocam_outlined),
        const Align(
          alignment: Alignment.bottomRight,
          child: Padding(
            padding: EdgeInsets.all(4),
            child: DecoratedBox(
              decoration: BoxDecoration(
                color: Colors.black54,
                borderRadius: BorderRadius.all(Radius.circular(4)),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                child: Icon(
                  Icons.play_arrow_rounded,
                  color: Colors.white,
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
        color: colors.tertiaryColor,
        child: Icon(icon, color: colors.borderPrimary),
      );
}
