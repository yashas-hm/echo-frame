import 'dart:io';

import 'package:echo_frame/database/database.dart';
import 'package:echo_frame/models/indexing_progress.dart';
import 'package:echo_frame/services/indexing_service.dart';
import 'package:echo_frame/utilities/utilities.dart'
    show ContextExtensions, Prefs;
import 'package:echo_frame/views/timeline/components/photo_tile.dart';
import 'package:echo_frame/views/timeline/components/timeline_search_bar.dart';
import 'package:echo_frame/views/timeline/provider/timeline_provider.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

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
  final _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _hasLibrary = Prefs.libraryRootPath != null;
    if (!_hasLibrary) {
      WidgetsBinding.instance.addPostFrameCallback((_) => _showSetupDialog());
    }
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 300) {
      ref.read(timelineProvider.notifier).loadNextPage();
    }
  }

  Future<void> _showSetupDialog() async {
    await showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (ctx) => AlertDialog(
        title: const Text('Choose your photo library'),
        content: const Text(
          'EchoFrame keeps your photos organised in a YYYY/MonthName folder '
          'structure on your drive. Select the root folder where your photos '
          'are stored — or where you\'d like them organised.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(),
            child: const Text('Not now'),
          ),
          FilledButton(
            onPressed: () async {
              Navigator.of(ctx).pop();
              await _pickLibraryFolder();
            },
            child: const Text('Choose Folder'),
          ),
        ],
      ),
    );
  }

  Future<void> _pickLibraryFolder() async {
    final path = await FilePicker.getDirectoryPath(
      dialogTitle: 'Choose your EchoFrame library folder',
    );
    if (path == null || !mounted) return;

    final echoframeDir = EchoDatabase.echoframeDir(path);
    final isExisting = File('$echoframeDir/echo.db').existsSync();

    if (!isExisting) {
      await Directory(echoframeDir).create(recursive: true);
    }

    await EchoDatabase.open(path);
    Prefs.libraryRootPath = path;

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
    if (_progress != null) return _buildIndexing(context);
    if (!_hasLibrary) return _buildEmptyState(context);
    return _buildTimeline(context);
  }

  Widget _buildTimeline(BuildContext context) {
    final timelineAsync = ref.watch(timelineProvider);
    return Scaffold(
      body: Stack(
        children: [
          timelineAsync.when(
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (e, _) => Center(child: Text('Error loading library: $e')),
            data: (timeline) {
              if (timeline.loaded.isEmpty) {
                return Center(
                  child: Text(timeline.query.isEmpty
                      ? 'No photos indexed yet.'
                      : 'No results for "${timeline.query}".'),
                );
              }
              return CustomScrollView(
                controller: _scrollController,
                slivers: [
                  const SliverToBoxAdapter(
                    child: SizedBox(height: TimelineSearchBar.height),
                  ),
                  for (final month in timeline.byMonth) ...[
                    SliverToBoxAdapter(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 17),
                        child: Text(
                          DateFormat('MMMM yyyy')
                              .format(DateTime(month.year, month.month)),
                          style: Theme.of(context)
                              .textTheme
                              .titleSmall
                              ?.copyWith(fontWeight: FontWeight.w600),
                        ),
                      ),
                    ),
                    SliverGrid.builder(
                      gridDelegate:
                          const SliverGridDelegateWithMaxCrossAxisExtent(
                        maxCrossAxisExtent: 180,
                        crossAxisSpacing: 2,
                        mainAxisSpacing: 2,
                      ),
                      itemCount: month.items.length,
                      itemBuilder: (_, i) => PhotoTile(item: month.items[i]),
                    ),
                  ],
                  if (timeline.hasMore)
                    const SliverToBoxAdapter(
                      child: Padding(
                        padding: EdgeInsets.all(24),
                        child: Center(child: CircularProgressIndicator()),
                      ),
                    ),
                ],
              );
            },
          ),
          const Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: TimelineSearchBar(),
          ),
        ],
      ),
    );
  }

  Widget _buildIndexing(BuildContext context) {
    final p = _progress!;
    return Center(
      child: SizedBox(
        width: 320,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Indexing library…',
                style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: 16),
            LinearProgressIndicator(),
            const SizedBox(height: 8),
            Text(p.phase == IndexingPhase.reading
                ? 'Reading metadata for ${p.newFiles} files…'
                : '${p.filesFound} files found'),
            if (p.currentDir != null) ...[
              const SizedBox(height: 4),
              Text(
                p.currentDir!,
                style: TextStyle(
                  color: context.colors.textSecondary,
                  fontSize: 12,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildEmptyState(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.photo_library_outlined,
              size: 72, color: context.colors.borderPrimary),
          const SizedBox(height: 20),
          Text('No library selected',
              style: Theme.of(context).textTheme.titleMedium),
          const SizedBox(height: 24),
          FilledButton.icon(
            onPressed: _showSetupDialog,
            icon: const Icon(Icons.add_rounded),
            label: const Text('Add Frame Path'),
          ),
        ],
      ),
    );
  }
}
