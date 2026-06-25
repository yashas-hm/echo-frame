import 'dart:developer' as dev;

import 'package:echo_frame/components/empty_view.dart';
import 'package:echo_frame/components/error_view.dart';
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

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final trashAsync = ref.watch(trashProvider);

    return Scaffold(
      body: trashAsync.when(
        loading: () => const LoadingView(text: 'Loading bin'),
        error: (e, st) {
          dev.log(
            'Failed to load bin: $e',
            stackTrace: st,
            name: 'TrashScreen.build',
          );
          return ErrorView(
            errorMessage: 'Failed to load bin',
            description: 'Something unexpected occurred. Please try again.',
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
            searchEnabled: false,
          );
        },
      ),
    );
  }
}
