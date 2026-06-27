import 'dart:developer' as dev;

import 'package:echo_frame/components/buttons/buttons.dart';
import 'package:echo_frame/constants/constants.dart'
    show Styles, Sizes, SpacerRegular, SpacerSmall;
import 'package:echo_frame/database/daos/tag_dao.dart';
import 'package:echo_frame/models/media/media.dart' show MediaItem;
import 'package:echo_frame/models/media/media.dart' show Tag;
import 'package:echo_frame/theme/theme.dart';
import 'package:echo_frame/utilities/utilities.dart' show ContextExtensions;
import 'package:echo_frame/views/gallery/components/tag_row.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

part '../provider/tags_provider.dart';

class GalleryInfoPanel extends StatelessWidget {
  const GalleryInfoPanel({
    super.key,
    required this.item,
    required this.onClosePressed,
  });

  final MediaItem item;
  final VoidCallback onClosePressed;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;

    return Container(
      width: 260,
      color: colors.surfacePrimary,
      padding: EdgeInsets.all(Sizes.cardPadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Info',
                style: Styles.regularBold(color: colors.textPrimary),
              ),
              EFIconButton(
                icon: Icons.clear_rounded,
                onPressed: onClosePressed,
              ),
            ],
          ),
          SpacerRegular(),
          _row(
            Icons.calendar_today_outlined,
            _formatDate(item.capturedAt),
            colors,
          ),
          if (item.modifiedAt != null)
            _row(
              Icons.edit_calendar_outlined,
              _formatDate(item.modifiedAt),
              colors,
            ),
          if (item.width != null && item.height != null)
            _row(
              Icons.photo_size_select_actual_outlined,
              '${item.width} × ${item.height}',
              colors,
            ),
          if (item.cameraMake != null || item.cameraModel != null)
            _row(
              Icons.camera_outlined,
              [item.cameraMake, item.cameraModel].nonNulls.join(' '),
              colors,
            ),
          if (item.latitude != null && item.longitude != null)
            _row(
              Icons.location_on_outlined,
              '${item.latitude!.toStringAsFixed(4)}, '
              '${item.longitude!.toStringAsFixed(4)}',
              colors,
            ),
          _row(
            Icons.insert_drive_file_outlined,
            item.filePath.split('/').last,
            colors,
          ),
          TagRow(item: item),
        ],
      ),
    );
  }

  Widget _row(IconData icon, String text, AppThemeColors colors) => Padding(
        padding: const EdgeInsets.only(bottom: 14),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icon, size: Sizes.iconSizeSmall, color: colors.textSecondary),
            SpacerSmall(),
            Expanded(
              child: Text(
                text,
                style: Styles.small(color: colors.textPrimary),
              ),
            ),
          ],
        ),
      );

  String _formatDate(DateTime? dt) {
    if (dt == null) return 'Unknown date';
    return DateFormat('d MMM yyyy  HH:mm').format(dt);
  }
}
