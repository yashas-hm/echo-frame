import 'package:echo_frame/components/buttons/buttons.dart' show EFIconButton;
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
    this.onDeletePressed,
  });

  final MediaItem item;
  final VoidCallback? onInfoPressed;
  final VoidCallback? onDeletePressed;

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
            onPressed: () =>
                actions.setFavourite(item.id, value: !item.isFavorite),
          ),
          EFIconButton(
            icon: Icons.delete_outline_rounded,
            onPressed: onDeletePressed,
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
