import 'dart:convert';
import 'dart:io';

import 'package:echo_frame/database/database.dart';
import 'package:echo_frame/services/indexing_pipeline.dart';
import 'package:echo_frame/services/library_service.dart';
import 'package:echo_frame/utilities/utilities.dart' show Prefs;
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

class TimelineScreen extends StatefulWidget {
  const TimelineScreen({super.key});

  @override
  State<TimelineScreen> createState() => _TimelineScreenState();
}

class _TimelineScreenState extends State<TimelineScreen> {
  bool _hasLibrary = false;
  IndexingProgress? _progress;

  @override
  void initState() {
    super.initState();
    _hasLibrary = Prefs.libraryRootPath != null;
    if (!_hasLibrary) {
      WidgetsBinding.instance.addPostFrameCallback((_) => _showSetupDialog());
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
    final path = await FilePicker.platform.getDirectoryPath(
      dialogTitle: 'Choose your EchoFrame library folder',
    );
    if (path == null || !mounted) return;

    final echoDir = Directory(EchoDatabase.echoframeDir(path));
    await echoDir.create(recursive: true);
    await File('${echoDir.path}/echo_config.json').writeAsString(
      jsonEncode({
        'version': 1,
        'createdAt': DateTime.now().toUtc().toIso8601String(),
      }),
    );

    await EchoDatabase.open(path);
    Prefs.libraryRootPath = path;

    final structure = await LibraryService.discover(path);

    if (!mounted) return;
    setState(() => _hasLibrary = true);

    await for (final progress in IndexingPipeline.run(
      libraryRoot: path,
      months: structure.months,
    )) {
      if (!mounted) return;
      setState(() => _progress = progress.isDone ? null : progress);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_progress != null) return _buildIndexing(context);
    if (!_hasLibrary) return _buildEmptyState(context);

    // Phase 3: replace with actual photo grid
    return const Scaffold(body: Center(child: Text('Timeline')));
  }

  Widget _buildIndexing(BuildContext context) {
    final p = _progress!;
    final colors = Theme.of(context).colorScheme;
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
                    style: TextStyle(color: colors.outline, fontSize: 12)),
              ],
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildEmptyState(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.photo_library_outlined,
                size: 72, color: colors.outlineVariant),
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
