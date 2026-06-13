import 'dart:convert';
import 'dart:io';

import 'package:echo_frame/database/database.dart';
import 'package:echo_frame/services/indexing_service.dart';
import 'package:echo_frame/services/library_service.dart';
import 'package:echo_frame/theme/theme.dart';
import 'package:echo_frame/utilities/utilities.dart' show Prefs;
import 'package:echo_frame/views/timeline/photo_tile.dart';
import 'package:echo_frame/views/timeline/provider/timeline_provider.dart';
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

    final echoDir = Directory(EchoDatabase.echoframeDir(path));
    await echoDir.create(recursive: true);
    await File('${echoDir.path}/echo_config.json').writeAsString(
      jsonEncode({
        'version': 1,
        'createdAt': DateTime.now().toUtc().toIso8601String(),
        'themeMode': Prefs.themeMode.name,
      }),
    );

    await EchoDatabase.open(path);
    Prefs.libraryRootPath = path;

    final structure = await LibraryService.discover(path);

    if (!mounted) return;
    setState(() => _hasLibrary = true);

    await for (final progress in IndexingService.run(
      libraryRoot: path,
      months: structure.months,
    )) {
      if (!mounted) return;
      setState(() => _progress = progress.isDone ? null : progress);
    }

    // Trigger the timeline provider to load from the newly populated DB.
    ref.invalidate(timelineProvider);
  }

  @override
  Widget build(BuildContext context) {
    if (_progress != null) return _buildIndexing(context);
    if (!_hasLibrary) return _buildEmptyState(context);
    return _buildTimeline(context);
  }

  Widget _buildTimeline(BuildContext context) {
    final state = ref.watch(timelineProvider);
    return state.when(
      loading: () =>
          const Scaffold(body: Center(child: CircularProgressIndicator())),
      error: (e, _) =>
          Scaffold(body: Center(child: Text('Error loading library: $e'))),
      data: (timeline) {
        if (timeline.loaded.isEmpty) {
          return const Scaffold(
            body: Center(child: Text('No photos indexed yet.')),
          );
        }
        return Scaffold(
          body: CustomScrollView(
            controller: _scrollController,
            slivers: [
              for (final month in timeline.loaded) ...[
                SliverPersistentHeader(
                  pinned: true,
                  delegate: _MonthHeaderDelegate(month),
                ),
                SliverGrid.builder(
                  gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
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
          ),
        );
      },
    );
  }

  Widget _buildIndexing(BuildContext context) {
    final p = _progress!;
    return Scaffold(
      body: Center(
        child: SizedBox(
          width: 320,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Indexing library…',
                  style: Theme.of(context).textTheme.titleMedium),
              const SizedBox(height: 16),
              LinearProgressIndicator(value: p.fraction),
              const SizedBox(height: 8),
              Text('${p.completed} of ${p.total} months'),
              if (p.currentFolder != null) ...[
                const SizedBox(height: 4),
                Text(p.currentFolder!,
                    style: TextStyle(
                        color: context.colors.textSecondary, fontSize: 12)),
              ],
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildEmptyState(BuildContext context) {
    return Scaffold(
      body: Center(
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
      ),
    );
  }
}

class _MonthHeaderDelegate extends SliverPersistentHeaderDelegate {
  _MonthHeaderDelegate(this.month);

  final MonthData month;

  @override
  double get minExtent => 52;

  @override
  double get maxExtent => 52;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return ColoredBox(
      color: context.colors.background,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 17),
        child: Text(
          '${month.monthName} ${month.year}',
          style: Theme.of(context)
              .textTheme
              .titleSmall
              ?.copyWith(fontWeight: FontWeight.w600),
        ),
      ),
    );
  }

  @override
  bool shouldRebuild(_MonthHeaderDelegate old) =>
      month.year != old.month.year || month.month != old.month.month;
}
