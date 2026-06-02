import 'package:echo_frame/views/import/import_provider.dart';
import 'package:echo_frame/views/import/import_report.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ImportScreen extends ConsumerStatefulWidget {
  const ImportScreen({super.key});

  @override
  ConsumerState<ImportScreen> createState() => _ImportScreenState();
}

class _ImportScreenState extends ConsumerState<ImportScreen> {
  String? _takeoutDir;

  Future<void> _pickTakeout() async {
    final path = await FilePicker.platform.getDirectoryPath(
      dialogTitle: 'Choose Google Photos Takeout folder',
    );
    if (path != null && mounted) setState(() => _takeoutDir = path);
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(importProvider);

    return switch (state.phase) {
      ImportPhase.idle => _buildIdle(context, state),
      ImportPhase.discovering =>
        _buildSpinner('Scanning Takeout folder…'),
      ImportPhase.review => _buildReview(context, state),
      ImportPhase.importing => _buildImporting(context, state),
      ImportPhase.done => _buildDone(context, state),
      ImportPhase.error => _buildError(context, state),
    };
  }

  // ── Idle ──────────────────────────────────────────────────────────────────

  Widget _buildIdle(BuildContext context, ImportState state) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;
    final libraryRoot = state.libraryRoot;
    final canScan = _takeoutDir != null && libraryRoot != null;

    if (libraryRoot == null) {
      return _buildSpinner('No library selected — set up a library first');
    }

    return Scaffold(
      body: Center(
        child: SizedBox(
          width: 480,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Import from Google Photos',
                  style: theme.textTheme.headlineSmall
                      ?.copyWith(fontWeight: FontWeight.w600)),
              const SizedBox(height: 4),
              Text(
                'Point to your Google Takeout export folder. EchoFrame will '
                'match metadata sidecars, fix timestamps, and copy photos into '
                'your library.',
                style: theme.textTheme.bodyMedium
                    ?.copyWith(color: colors.outline),
              ),
              const SizedBox(height: 32),
              _Label('Takeout folder'),
              const SizedBox(height: 8),
              _PathRow(
                path: _takeoutDir,
                placeholder: 'No folder selected',
                trailing: FilledButton.tonal(
                  onPressed: _pickTakeout,
                  child: const Text('Choose'),
                ),
              ),
              const SizedBox(height: 20),
              _Label('Destination (library root)'),
              const SizedBox(height: 8),
              _PathRow(path: libraryRoot, readOnly: true),
              const SizedBox(height: 32),
              Align(
                alignment: Alignment.centerRight,
                child: FilledButton.icon(
                  onPressed: canScan
                      ? () => ref
                          .read(importProvider.notifier)
                          .discover(_takeoutDir!)
                      : null,
                  icon: const Icon(Icons.search_rounded),
                  label: const Text('Scan'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ── Review ────────────────────────────────────────────────────────────────

  Widget _buildReview(BuildContext context, ImportState state) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;
    final d = state.discovered!;
    final notifier = ref.read(importProvider.notifier);
    final total = d.pairs.length;

    return Scaffold(
      body: Center(
        child: SizedBox(
          width: 480,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Ready to import',
                  style: theme.textTheme.headlineSmall
                      ?.copyWith(fontWeight: FontWeight.w600)),
              const SizedBox(height: 24),
              if (total == 0)
                _SummaryRow(
                  icon: Icons.folder_off_outlined,
                  color: colors.outline,
                  text: 'No media files found in the selected folder',
                )
              else ...[
                if (d.withSidecar > 0)
                  _SummaryRow(
                    icon: Icons.check_circle_outline_rounded,
                    color: colors.primary,
                    text:
                        '${d.withSidecar} photo${d.withSidecar == 1 ? '' : 's'} '
                        'with Takeout metadata',
                  ),
                if (d.withoutSidecar > 0) ...[
                  const SizedBox(height: 10),
                  _SummaryRow(
                    icon: Icons.info_outline_rounded,
                    color: colors.secondary,
                    text:
                        '${d.withoutSidecar} photo${d.withoutSidecar == 1 ? '' : 's'} '
                        'without sidecar (will use EXIF)',
                  ),
                ],
                if (d.unmatched.isNotEmpty) ...[
                  const SizedBox(height: 10),
                  _SummaryRow(
                    icon: Icons.warning_amber_rounded,
                    color: colors.tertiary,
                    text:
                        '${d.unmatched.length} sidecar${d.unmatched.length == 1 ? '' : 's'} '
                        'with no matching file — will be skipped',
                  ),
                ],
              ],
              const SizedBox(height: 32),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: notifier.reset,
                    child: const Text('Cancel'),
                  ),
                  const SizedBox(width: 12),
                  FilledButton.icon(
                    onPressed: total == 0 ? null : notifier.apply,
                    icon: const Icon(Icons.download_rounded),
                    label: Text(total == 0
                        ? 'Nothing to import'
                        : 'Import $total Photo${total == 1 ? '' : 's'}'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ── Importing ─────────────────────────────────────────────────────────────

  Widget _buildImporting(BuildContext context, ImportState state) {
    final theme = Theme.of(context);
    final fraction =
        state.total == 0 ? null : state.imported / state.total;

    return Scaffold(
      body: Center(
        child: SizedBox(
          width: 320,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Importing photos…', style: theme.textTheme.titleMedium),
              const SizedBox(height: 16),
              LinearProgressIndicator(value: fraction),
              const SizedBox(height: 8),
              Text('${state.imported} of ${state.total}'),
            ],
          ),
        ),
      ),
    );
  }

  // ── Done ──────────────────────────────────────────────────────────────────

  Widget _buildDone(BuildContext context, ImportState state) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;
    final notifier = ref.read(importProvider.notifier);
    final unmatched = state.discovered?.unmatched ?? [];

    return Scaffold(
      body: Center(
        child: SizedBox(
          width: 480,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(Icons.check_circle_outline_rounded,
                      color: colors.primary, size: 28),
                  const SizedBox(width: 10),
                  Text(
                    '${state.total} photo${state.total == 1 ? '' : 's'} imported',
                    style: theme.textTheme.headlineSmall
                        ?.copyWith(fontWeight: FontWeight.w600),
                  ),
                ],
              ),
              if (unmatched.isNotEmpty) ...[
                const SizedBox(height: 24),
                ImportReport(unmatched: unmatched),
              ],
              const SizedBox(height: 32),
              Align(
                alignment: Alignment.centerRight,
                child: FilledButton(
                  onPressed: notifier.reset,
                  child: const Text('Done'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ── Error ─────────────────────────────────────────────────────────────────

  Widget _buildError(BuildContext context, ImportState state) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;
    final notifier = ref.read(importProvider.notifier);

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.error_outline_rounded, size: 56, color: colors.error),
            const SizedBox(height: 16),
            Text('Import failed', style: theme.textTheme.titleMedium),
            const SizedBox(height: 8),
            SizedBox(
              width: 360,
              child: Text(
                state.error ?? 'Unknown error',
                textAlign: TextAlign.center,
                style:
                    theme.textTheme.bodySmall?.copyWith(color: colors.outline),
              ),
            ),
            const SizedBox(height: 24),
            FilledButton(
              onPressed: notifier.reset,
              child: const Text('Start over'),
            ),
          ],
        ),
      ),
    );
  }

  // ── Helpers ───────────────────────────────────────────────────────────────

  Widget _buildSpinner(String label) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const CircularProgressIndicator(),
            const SizedBox(height: 16),
            Text(label),
          ],
        ),
      ),
    );
  }
}

// ── Private widgets ───────────────────────────────────────────────────────────

class _Label extends StatelessWidget {
  const _Label(this.text);
  final String text;

  @override
  Widget build(BuildContext context) => Text(
        text,
        style: Theme.of(context)
            .textTheme
            .labelMedium
            ?.copyWith(color: Theme.of(context).colorScheme.outline),
      );
}

class _PathRow extends StatelessWidget {
  const _PathRow({
    required this.path,
    this.placeholder,
    this.trailing,
    this.readOnly = false,
  });

  final String? path;
  final String? placeholder;
  final Widget? trailing;
  final bool readOnly;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        color: colors.surfaceContainerLow,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: colors.outlineVariant),
      ),
      child: Row(
        children: [
          Icon(
            readOnly
                ? Icons.folder_rounded
                : (path != null
                    ? Icons.folder_open_rounded
                    : Icons.folder_outlined),
            size: 18,
            color: path != null ? colors.primary : colors.outlineVariant,
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              path ?? placeholder ?? '',
              style: theme.textTheme.bodySmall?.copyWith(
                color: path != null ? colors.onSurface : colors.outlineVariant,
                fontFamily: 'monospace',
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ),
          if (trailing != null) ...[
            const SizedBox(width: 8),
            trailing!,
          ],
        ],
      ),
    );
  }
}

class _SummaryRow extends StatelessWidget {
  const _SummaryRow({
    required this.icon,
    required this.color,
    required this.text,
  });

  final IconData icon;
  final Color color;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, size: 18, color: color),
        const SizedBox(width: 10),
        Expanded(
          child: Text(text, style: Theme.of(context).textTheme.bodyMedium),
        ),
      ],
    );
  }
}
