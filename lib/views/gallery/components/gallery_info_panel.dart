import 'package:echo_frame/database/daos/media_dao.dart';
import 'package:echo_frame/database/database.dart';
import 'package:echo_frame/models/media_item.dart';
import 'package:echo_frame/utilities/utilities.dart' show ContextExtensions;
import 'package:echo_frame/views/favorites/provider/favorites_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

class GalleryInfoPanel extends ConsumerStatefulWidget {
  const GalleryInfoPanel({super.key, required this.item});

  final MediaItem item;

  @override
  ConsumerState<GalleryInfoPanel> createState() => _PhotoDetailPanelState();
}

class _PhotoDetailPanelState extends ConsumerState<GalleryInfoPanel> {
  late bool _isFavorite;
  bool _toggling = false;

  @override
  void initState() {
    super.initState();
    _isFavorite = widget.item.isFavorite;
  }

  @override
  void didUpdateWidget(GalleryInfoPanel old) {
    super.didUpdateWidget(old);
    if (old.item.id != widget.item.id) {
      _isFavorite = widget.item.isFavorite;
    }
  }

  Future<void> _toggleFavorite() async {
    if (_toggling || !EchoDatabase.isOpen) return;
    setState(() {
      _toggling = true;
      _isFavorite = !_isFavorite;
    });
    await MediaDao(EchoDatabase.instance)
        .setFavorite(widget.item.id, value: _isFavorite);
    ref.invalidate(favoritesProvider);
    if (mounted) setState(() => _toggling = false);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      width: 260,
      color: context.colors.surfacePrimary,
      padding: const EdgeInsets.fromLTRB(16, 24, 16, 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ── Favourite toggle ─────────────────────────────────────────
          SizedBox(
            width: double.infinity,
            child: OutlinedButton.icon(
              onPressed: _toggling ? null : _toggleFavorite,
              icon: Icon(
                _isFavorite
                    ? Icons.favorite_rounded
                    : Icons.favorite_outline_rounded,
                color: _isFavorite ? context.colors.errorPrimary : null,
                size: 18,
              ),
              label: Text(_isFavorite ? 'Favourited' : 'Add to favourites'),
              style: OutlinedButton.styleFrom(
                foregroundColor: _isFavorite
                    ? context.colors.errorPrimary
                    : context.colors.textPrimary,
              ),
            ),
          ),
          const SizedBox(height: 20),

          // ── Metadata ─────────────────────────────────────────────────
          Text('Info', style: theme.textTheme.labelLarge),
          const SizedBox(height: 12),
          _Row(
            Icons.calendar_today_outlined,
            _formatDate(
              widget.item.capturedAt,
            ),
          ),
          if (widget.item.meta.modifiedAt != null)
            _Row(
              Icons.edit_calendar_outlined,
              _formatDate(
                widget.item.meta.modifiedAt,
              ),
            ),
          if (widget.item.width != null && widget.item.height != null)
            _Row(
              Icons.photo_size_select_actual_outlined,
              '${widget.item.width} × ${widget.item.height}',
            ),
          if (widget.item.cameraMake != null || widget.item.cameraModel != null)
            _Row(
              Icons.camera_outlined,
              [widget.item.cameraMake, widget.item.cameraModel]
                  .nonNulls
                  .join(' '),
            ),
          if (widget.item.latitude != null && widget.item.longitude != null)
            _Row(
              Icons.location_on_outlined,
              '${widget.item.latitude!.toStringAsFixed(4)}, '
              '${widget.item.longitude!.toStringAsFixed(4)}',
            ),
          _Row(
            Icons.insert_drive_file_outlined,
            widget.item.filePath.split('/').last,
          ),
        ],
      ),
    );
  }

  static String _formatDate(DateTime? dt) {
    if (dt == null) return 'Unknown date';
    return DateFormat('d MMM yyyy  HH:mm').format(dt);
  }
}

class _Row extends StatelessWidget {
  const _Row(this.icon, this.text);

  final IconData icon;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 15, color: context.colors.textSecondary),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              text,
              style: Theme.of(context)
                  .textTheme
                  .bodySmall
                  ?.copyWith(color: context.colors.textPrimary),
            ),
          ),
        ],
      ),
    );
  }
}
