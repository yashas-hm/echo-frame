import 'dart:developer' as dev;

import 'package:echo_frame/components/buttons/buttons.dart';
import 'package:echo_frame/components/dialog.dart';
import 'package:echo_frame/components/empty_view.dart';
import 'package:echo_frame/components/error_view.dart';
import 'package:echo_frame/constants/constants.dart';
import 'package:echo_frame/utilities/utilities.dart';
import 'package:echo_frame/views/media/components/loading_view.dart';
import 'package:echo_frame/views/media/components/media_list_view.dart';
import 'package:echo_frame/views/media/provider/media_collection_notifier.dart'
    show MediaCollectionSource;
import 'package:echo_frame/views/media/provider/trash_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class TrashScreen extends ConsumerWidget {
  const TrashScreen({super.key});

  static const String path = '/trash';

  static GoRoute get route => GoRoute(
        path: path,
        builder: (_, __) => const TrashScreen(),
      );

  Future<void> _onEmptyBin(BuildContext context, WidgetRef ref) async {
    final confirmed = await EFDialog.show(
      context,
      title: 'Empty Bin',
      description:
          'All items in the bin will be permanently deleted. This cannot be undone.',
      confirmText: 'Empty Bin',
      cancelText: 'Cancel',
      icon: const Icon(Icons.delete_forever_rounded),
    );
    if (confirmed != true) return;
    final success = await ref.read(trashProvider.notifier).emptyAll();
    if (!success && context.mounted) {
      dev.log('Failed to empty bin', name: 'TrashScreen._onEmptyBin');
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final trashAsync = ref.watch(trashProvider);
    final colors = context.colors;
    final hasItems = trashAsync.value?.flatItems.isNotEmpty ?? false;

    return Scaffold(
      body: Padding(
        padding: EdgeInsets.only(
          left: Sizes.spacingSmall,
          top: Sizes.edgePadding,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (hasItems)
              Container(
                height: Sizes.inputHeight,
                margin: EdgeInsets.only(
                  right: Sizes.edgePadding,
                ),
                decoration: BoxDecoration(
                  color: colors.surfacePrimary,
                  borderRadius: BorderRadius.circular(Sizes.cardBorderRadius),
                  boxShadow: [
                    BoxShadow(
                      color: colors.borderPrimary.withValues(alpha: 0.5),
                      spreadRadius: 0.8,
                      blurRadius: 4,
                    )
                  ],
                ),
                alignment: Alignment.center,
                padding: EdgeInsets.all(Sizes.spacingSmallRegular),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'Items in the bin will be permanently deleted',
                      style: Styles.regular(
                        color: colors.textPrimary,
                      ),
                    ),
                    EFErrorButton(
                      onPressed: () => _onEmptyBin(context, ref),
                      text: 'Empty Bin',
                      icon: Icons.delete_outline_rounded,
                    ),
                  ],
                ),
              ),
            Flexible(
              child: trashAsync.when(
                loading: () => const LoadingView(text: 'Loading bin'),
                error: (e, st) {
                  dev.log(
                    'Failed to load bin: $e',
                    stackTrace: st,
                    name: 'TrashScreen.build',
                  );
                  return ErrorView(
                    errorMessage: 'Failed to load bin',
                    description:
                        'Something unexpected occurred. Please try again.',
                    buttonText: 'Try Again',
                    onButtonPressed: () => ref.invalidate(trashProvider),
                  );
                },
                data: (trash) {
                  final items = trash.flatItems;
                  if (items.isEmpty) {
                    return const EmptyView(
                      icon: Icons.delete_outline_rounded,
                      title: 'Bin is empty',
                      message: 'Deleted media will appear here',
                    );
                  }
                  return MediaListView(
                    state: trash,
                    source: MediaCollectionSource.trash,
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
