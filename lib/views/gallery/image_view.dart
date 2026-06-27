import 'dart:io';

import 'package:echo_frame/models/media/media.dart' show MediaItem;
import 'package:echo_frame/utilities/utilities.dart' show ContextExtensions;
import 'package:flutter/material.dart';

class ImageView extends StatelessWidget {
  const ImageView({super.key, required this.item});

  final MediaItem item;

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: item.id,
      flightShuttleBuilder: (_, __, ___, ____, _____) => Image.file(
        File(item.filePath),
        fit: BoxFit.contain,
      ),
      child: InteractiveViewer(
        child: Center(
          child: Image.file(
            File(item.filePath),
            fit: BoxFit.contain,
            errorBuilder: (_, __, ___) => Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.broken_image_outlined,
                  size: 64,
                  color: context.colors.textPrimary.withValues(alpha: 0.38),
                ),
                const SizedBox(height: 8),
                Text(
                  'File not available',
                  style: TextStyle(
                    color: context.colors.textPrimary.withValues(alpha: 0.54),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
