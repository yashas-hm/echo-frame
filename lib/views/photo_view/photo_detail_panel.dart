import 'package:echo_frame/models/media_item.dart';
import 'package:flutter/material.dart';

class PhotoDetailPanel extends StatelessWidget {
  const PhotoDetailPanel({super.key, required this.item});

  final MediaItem item;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;

    return Container(
      width: 260,
      color: colors.surfaceContainer,
      padding: const EdgeInsets.fromLTRB(16, 24, 16, 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Info', style: theme.textTheme.labelLarge),
          const SizedBox(height: 20),
          _Row(Icons.calendar_today_outlined, _formatDate(item.capturedAt)),
          if (item.width != null && item.height != null)
            _Row(Icons.photo_size_select_actual_outlined,
                '${item.width} × ${item.height}'),
          if (item.cameraMake != null || item.cameraModel != null)
            _Row(Icons.camera_outlined,
                [item.cameraMake, item.cameraModel].nonNulls.join(' ')),
          if (item.latitude != null && item.longitude != null)
            _Row(Icons.location_on_outlined,
                '${item.latitude!.toStringAsFixed(4)}, ${item.longitude!.toStringAsFixed(4)}'),
          _Row(Icons.insert_drive_file_outlined, item.filePath.split('/').last),
        ],
      ),
    );
  }

  static String _formatDate(DateTime? dt) {
    if (dt == null) return 'Unknown date';
    const months = [
      'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
      'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec',
    ];
    final h = dt.hour.toString().padLeft(2, '0');
    final m = dt.minute.toString().padLeft(2, '0');
    return '${dt.day} ${months[dt.month - 1]} ${dt.year}  $h:$m';
  }
}

class _Row extends StatelessWidget {
  const _Row(this.icon, this.text);

  final IconData icon;
  final String text;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 15, color: colors.outline),
          const SizedBox(width: 8),
          Expanded(
            child: Text(text,
                style: Theme.of(context)
                    .textTheme
                    .bodySmall
                    ?.copyWith(color: colors.onSurface)),
          ),
        ],
      ),
    );
  }
}
