import 'dart:io';

import 'package:echo_frame/models/media_item.dart';
import 'package:echo_frame/views/photo_view/photo_view_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class PhotoTile extends StatelessWidget {
  const PhotoTile({super.key, required this.item});

  final MediaItem item;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return GestureDetector(
      onTap: () => context.push(PhotoViewScreen.route(item.id)),
      child: SizedBox.expand(
        child: Image.file(
          File(item.filePath),
          cacheWidth: item.width == null ? 180 : item.width! ~/ 10,
          cacheHeight: item.height == null ? 180 : item.height! ~/ 10,
          fit: BoxFit.cover,
          errorBuilder: (_, __, ___) => ColoredBox(
            color: colors.surfaceContainerHighest,
            child:
                Icon(Icons.hide_image_outlined, color: colors.outlineVariant),
          ),
        ),
      ),
    );
  }
}
