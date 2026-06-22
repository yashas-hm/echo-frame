import 'package:echo_frame/components/buttons/buttons.dart' show EFIconButton;
import 'package:echo_frame/components/dialog.dart';
import 'package:echo_frame/components/snackbar.dart';
import 'package:echo_frame/constants/constants.dart' show Sizes;
import 'package:echo_frame/models/media_item.dart';
import 'package:echo_frame/views/gallery/provider/gallery_actions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ActionsTray extends ConsumerWidget {
  const ActionsTray({
    super.key,
    required this.item,
    this.onInfoPressed,
    this.onRemoveItem,
  });

  final MediaItem item;
  final VoidCallback? onInfoPressed;
  final VoidCallback? onRemoveItem;

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
                item.id,
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
              onPressed: () async {
                final success = await actions.restore(item);
                if (!context.mounted) return;
                if (success) {
                  onRemoveItem?.call();
                } else {
                  EFSnackbar.showError(
                    context,
                    message: 'Failed to restore item',
                  );
                }
              },
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
                  onRemoveItem?.call();
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
                final success = await actions.trash(item);
                if (!context.mounted) return;
                if (success) {
                  onRemoveItem?.call();
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
}
