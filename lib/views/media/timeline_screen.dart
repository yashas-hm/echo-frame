import 'dart:developer' as dev;
import 'dart:io';

import 'package:echo_frame/components/buttons/buttons.dart'
    show EFPrimaryButton, EFIconButton;
import 'package:echo_frame/components/dialog.dart';
import 'package:echo_frame/components/empty_view.dart';
import 'package:echo_frame/components/error_view.dart';
import 'package:echo_frame/constants/constants.dart';
import 'package:echo_frame/database/database.dart';
import 'package:echo_frame/models/indexing_progress.dart';
import 'package:echo_frame/services/indexing_service.dart';
import 'package:echo_frame/utilities/utilities.dart'
    show ContextExtensions, Prefs;
import 'package:echo_frame/views/import/import_screen.dart';
import 'package:echo_frame/views/media/components/loading_view.dart';
import 'package:echo_frame/views/media/components/media_list_view.dart';
import 'package:echo_frame/views/media/components/search_bar.dart';
import 'package:echo_frame/views/media/provider/media_collection_notifier.dart'
    show MediaCollectionSource;
import 'package:echo_frame/views/media/provider/search_focus_provider.dart';
import 'package:echo_frame/views/media/provider/timeline_provider.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class TimelineScreen extends ConsumerStatefulWidget {
  const TimelineScreen({super.key});

  static const String path = '/timeline';

  static GoRoute get route => GoRoute(
        path: path,
        builder: (_, __) => const TimelineScreen(),
      );

  @override
  ConsumerState<TimelineScreen> createState() => _TimelineScreenState();
}

class _TimelineScreenState extends ConsumerState<TimelineScreen> {
  bool _hasLibrary = false;
  IndexingProgress? _progress;

  @override
  void initState() {
    super.initState();
    _hasLibrary = Prefs.activeLibraryRoot != null;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_hasLibrary) {
        _startupIndex();
      } else {
        _showSetupDialog();
      }
    });
  }

  Future<void> _startupIndex() async {
    final path = Prefs.activeLibraryRoot;
    if (path == null || !mounted) return;
    final stream = IndexingService.autoIndex(libraryRoot: path);
    await for (final progress in stream) {
      if (!mounted) return;
      setState(() => _progress = progress.isDone ? null : progress);
    }
    if (mounted) ref.invalidate(timelineProvider);
  }

  Future<void> _showSetupDialog() async {
    final confirmed = await EFDialog.show(
      context,
      title: 'Choose your photo library',
      description: 'EchoFrame keeps your photos organised in a YYYY/MonthName '
          'folder structure on your drive. Select the root folder where your '
          'photos are stored or where you\'d like them organised.',
      confirmText: 'Choose Folder',
      cancelText: 'Not now',
    );
    if (confirmed == true) await _pickLibraryFolder();
  }

  Future<void> _pickLibraryFolder() async {
    final path = await FilePicker.getDirectoryPath(
      dialogTitle: 'Choose your EchoFrame library folder',
    );
    if (path == null || !mounted) return;

    final echoframeDir = EchoDatabase.echoframeDir(path);
    final isExisting = File('$echoframeDir/${Keys.dbFileName}').existsSync();

    if (!isExisting) {
      await Directory(echoframeDir).create(recursive: true);
    }

    await EchoDatabase.open(path);
    Prefs.addKnownLibrary(path);

    if (!mounted) return;
    setState(() => _hasLibrary = true);

    final stream = isExisting
        ? IndexingService.autoIndex(libraryRoot: path)
        : IndexingService.fullIndex(libraryRoot: path);

    await for (final progress in stream) {
      if (!mounted) return;
      setState(() => _progress = progress.isDone ? null : progress);
    }

    ref.invalidate(timelineProvider);
  }

  @override
  Widget build(BuildContext context) {
    if (_progress != null) return _buildIndexing();
    if (!_hasLibrary) {
      return Scaffold(
        body: EmptyView(
          icon: Icons.photo_library_outlined,
          title: 'No library selected',
          message: 'Choose a folder to get started',
          button: EFPrimaryButton(
            onPressed: _showSetupDialog,
            text: 'Add Frame Path',
            icon: Icons.add_rounded,
          ),
        ),
      );
    }
    return _buildTimeline();
  }

  Widget _buildTimeline() {
    final timelineAsync = ref.watch(timelineProvider);

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
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Flexible(
                  child: EFSearchBar(
                    focusNode: ref.read(searchFocusProvider),
                    initialQuery: timelineAsync.value?.query ?? '',
                    onTextChanged: (q) =>
                        ref.read(timelineProvider.notifier).setQuery(q),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(right: Sizes.edgePadding),
                  child: EFIconButton(
                    icon: Icons.add_rounded,
                    iconSize: Sizes.iconSizeMedium,
                    onPressed: () => context.push(ImportScreen.path),
                  ),
                ),
              ],
            ),
            Flexible(
              child: timelineAsync.when(
                loading: () => const LoadingView(text: 'Loading library'),
                error: (e, st) {
                  dev.log(
                    'Failed to load timeline: $e',
                    stackTrace: st,
                    name: 'TimelineScreen._buildTimeline',
                  );
                  return ErrorView(
                    errorMessage: 'Failed to load library',
                    description: 'Something unexpected occurred while loading '
                        'your library. Please try again.',
                    buttonText: 'Try Again',
                    onButtonPressed: () => ref.invalidate(timelineProvider),
                  );
                },
                data: (timeline) {
                  if (timeline.flatItems.isEmpty) {
                    return EmptyView(
                      icon: Icons.photo_library_outlined,
                      title: timeline.query.isEmpty
                          ? 'No media available'
                          : 'No results for "${timeline.query}"',
                      message: timeline.query.isEmpty
                          ? 'Import some photos to see them here'
                          : 'Try a different search term',
                      button: timeline.query.isEmpty
                          ? EFPrimaryButton(
                              onPressed: () => context.push(ImportScreen.path),
                              text: 'Import Media',
                              icon: Icons.add_rounded,
                            )
                          : null,
                    );
                  }
                  return MediaListView(
                    state: timeline,
                    source: MediaCollectionSource.timeline,
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildIndexing() {
    final p = _progress!;
    final colors = context.colors;

    return Scaffold(
      body: Center(
        child: SizedBox(
          width: Sizes.viewBoxWidth,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Indexing library',
                style: Styles.subtitle(
                  color: colors.textPrimary,
                ),
              ),
              const SpacerMedium(),
              const LinearProgressIndicator(),
              const SpacerRegular(),
              Text(
                p.phase == IndexingPhase.reading
                    ? 'Reading metadata for ${p.newFiles} files…'
                    : '${p.filesFound} files found',
                style: Styles.regular(
                  color: colors.textPrimary,
                ),
              ),
              if (p.currentDir != null) ...[
                const SpacerExtraSmall(),
                Text(
                  p.currentDir!,
                  style: Styles.small(
                    color: colors.textSecondary,
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
