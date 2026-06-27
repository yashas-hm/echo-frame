import 'package:echo_frame/components/buttons/buttons.dart' show EFIconButton;
import 'package:echo_frame/components/dialog.dart';
import 'package:echo_frame/components/snackbar.dart';
import 'package:echo_frame/constants/constants.dart' show Sizes;
import 'package:echo_frame/database/daos/media_dao.dart';
import 'package:echo_frame/database/database.dart';
import 'package:echo_frame/models/media/media.dart' show MediaItem, Tag;
import 'package:echo_frame/services/trash_service.dart';
import 'package:echo_frame/utilities/utilities.dart' show Prefs;
import 'package:echo_frame/views/gallery/components/gallery_info_panel.dart'
    show tagsProvider;
import 'package:echo_frame/views/media/favourites/favorites_screen.dart'
    show favoritesProvider;
import 'package:echo_frame/views/media/timeline/timeline_screen.dart'
    show timelineProvider;
import 'package:echo_frame/views/media/trash/trash_screen.dart'
    show trashProvider;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

part '../provider/gallery_actions_provider.dart';

class ActionsTray extends ConsumerWidget {
  const ActionsTray({
    super.key,
    required this.item,
    this.onInfoPressed,
    this.onItemRestored,
  });

  final MediaItem item;
  final VoidCallback? onInfoPressed;
  final void Function(String itemId)? onItemRestored;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final actions = ref.read(galleryActionsProvider);

    return Positioned(
      top: Sizes.spacingRegular,
      right: Sizes.spacingRegular,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.center,
        spacing: Sizes.spacingExtraExtraSmall,
        children: [
          EFIconButton(
            icon: item.isFavorite
                ? Icons.star_rounded
                : Icons.star_border_rounded,
            iconColor: item.isFavorite ? Colors.amber : null,
            onPressed: () async {
              final success = await actions.setFavourite(
                item,
                value: !item.isFavorite,
              );
              if (!context.mounted) return;
              if (!success) {
                EFSnackbar.showError(
                  context,
                  message: 'Failed to update favourite',
                );
              }
            },
          ),
          if (item.isTrashed) ...[
            EFIconButton(
              icon: Icons.restore_rounded,
              onPressed: () => _restore(context, actions),
            ),
            EFIconButton(
              icon: Icons.delete_forever_outlined,
              onPressed: () async {
                final confirmed = await EFDialog.show(
                  context,
                  title: 'Delete permanently?',
                  description: 'This cannot be undone.',
                  confirmText: 'Delete',
                );
                if (confirmed != true) return;
                if (!context.mounted) return;
                final success = await actions.permanentDelete(item);
                if (!context.mounted) return;
                if (success) {
                  EFSnackbar.showSuccess(
                    context,
                    message: 'Item permanently deleted',
                  );
                } else {
                  EFSnackbar.showError(
                    context,
                    message: 'Failed to delete item',
                  );
                }
              },
            ),
          ],
          if (!item.isTrashed)
            EFIconButton(
              icon: Icons.delete_outline_rounded,
              onPressed: () async {
                final trashedItem = await actions.trash(item);
                if (!context.mounted) return;
                if (trashedItem != null) {
                  EFSnackbar.showSuccess(
                    context,
                    message: 'Moved to trash',
                    actionText: 'Undo',
                    onActionPressed: () => _restore(
                      context,
                      actions,
                      trashedItem,
                      true,
                    ),
                  );
                } else {
                  EFSnackbar.showError(
                    context,
                    message: 'Failed to move item to trash',
                  );
                }
              },
            ),
          EFIconButton(
            icon: Icons.info_outline_rounded,
            onPressed: onInfoPressed,
          ),
        ],
      ),
    );
  }

  void _restore(
    BuildContext context,
    GalleryActions actions, [
    MediaItem? target,
    bool? undo,
  ]) async {
    final targetItem = target ?? item;
    final success = await actions.restore(targetItem, undo: undo ?? false);
    if (success && undo == true) onItemRestored?.call(targetItem.id);
    if (!context.mounted) return;
    if (success) {
      EFSnackbar.showSuccess(context, message: 'Item restored');
    } else {
      EFSnackbar.showError(context, message: 'Failed to restore item');
    }
  }
}
