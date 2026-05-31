import 'dart:io';

import 'package:echo_frame/models/media_item.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class PhotoTile extends StatelessWidget {
  const PhotoTile({super.key, required this.item});

  final MediaItem item;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return GestureDetector(
      onTap: () => context.push('/photo/${item.id}'),
      child: Image.file(
        File(item.filePath),
        cacheWidth: 150,
        cacheHeight: 150,
        fit: BoxFit.cover,
        errorBuilder: (_, __, ___) => ColoredBox(
          color: colors.surfaceContainerHighest,
          child: Icon(Icons.hide_image_outlined, color: colors.outlineVariant),
        ),
      ),
    );
  }
}
