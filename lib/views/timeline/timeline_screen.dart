import 'dart:convert';
import 'dart:io';

import 'package:echo_frame/database/database.dart';
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
  bool _loading = false;

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

    setState(() => _loading = true);
    try {
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

      if (mounted) setState(() { _hasLibrary = true; _loading = false; });
    } catch (e) {
      if (mounted) setState(() => _loading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_loading) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    if (!_hasLibrary) {
      return _buildEmptyState(context);
    }

    // Phase 3 will replace this with the actual photo grid
    return const Scaffold(body: Center(child: Text('Timeline')));
  }

  Widget _buildEmptyState(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.photo_library_outlined,
              size: 72,
              color: colors.outlineVariant,
            ),
            const SizedBox(height: 20),
            Text(
              'No library selected',
              style: Theme.of(context).textTheme.titleMedium,
            ),
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