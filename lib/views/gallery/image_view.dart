import 'dart:io';

import 'package:echo_frame/models/media_item.dart';
import 'package:echo_frame/theme/theme.dart';
import 'package:echo_frame/views/gallery/gallery_info_panel.dart';
import 'package:flutter/material.dart';

class ImageView extends StatelessWidget {
  const ImageView({super.key, required this.item});

  final MediaItem item;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: InteractiveViewer(
            child: Center(
              child: Image.file(
                File(item.filePath),
                fit: BoxFit.contain,
                errorBuilder: (_, __, ___) => Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.broken_image_outlined,
                        size: 64,
                        color: KnownColors.basicWhite.withValues(alpha: 0.38)),
                    const SizedBox(height: 8),
                    Text(
                      'File not available',
                      style: TextStyle(
                          color: KnownColors.basicWhite.withValues(alpha: 0.54)),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        GalleryInfoPanel(item: item),
      ],
    );
  }
}
