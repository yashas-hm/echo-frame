import 'package:echo_frame/models/discovery/discovery.dart' show DiscoveryError;
import 'package:echo_frame/utilities/utilities.dart' show ContextExtension;
import 'package:echo_frame/views/organizer/provider/organizer_provider.dart';
import 'package:echo_frame/widgets/folder_tree_preview.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class OrganizerScreen extends ConsumerStatefulWidget {
  const OrganizerScreen({super.key});

  static const String path = '/organize';

  static GoRoute get route => GoRoute(
        path: path,
        builder: (_, __) => const OrganizerScreen(),
      );

  @override
  ConsumerState<OrganizerScreen> createState() => _OrganizerScreenState();
}

class _OrganizerScreenState extends ConsumerState<OrganizerScreen> {
  String? _sourceDir;

  Future<void> _pickSource() async {
    final path = await FilePicker.getDirectoryPath(
      dialogTitle: 'Choose folder with unsorted photos',
    );
    if (path != null && mounted) setState(() => _sourceDir = path);
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(organizerProvider);

    return switch (state.phase) {
      OrganizerPhase.idle => _buildIdle(context, state),
      OrganizerPhase.discovering => _buildDiscovering(context, state),
      OrganizerPhase.review => _buildReview(context, state),
      OrganizerPhase.applying => _buildApplying(context, state),
      OrganizerPhase.done => _buildDone(context, state),
      OrganizerPhase.error => _buildError(context, state),
    };
  }

  // ── Idle ──────────────────────────────────────────────────────────────────

  Widget _buildIdle(BuildContext context, OrganizerState state) {
    final theme = Theme.of(context);
    final destRoot = state.destRoot;
    final canDiscover =
        _sourceDir != null && destRoot != null && _sourceDir != destRoot;

    if (destRoot == null) {
      return _buildCentered(
        Icon(Icons.folder_off_outlined,
            size: 56, color: context.colors.borderPrimary),
        'No library selected — set up a library first',
      );
    }

    return Scaffold(
      body: Center(
        child: SizedBox(
          width: 480,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Organize Photos',
                  style: theme.textTheme.headlineSmall
                      ?.copyWith(fontWeight: FontWeight.w600)),
              const SizedBox(height: 4),
              Text(
                'Sort a folder of unsorted photos into your library by date.',
                style: theme.textTheme.bodyMedium
                    ?.copyWith(color: context.colors.textSecondary),
              ),
              const SizedBox(height: 32),
              _SectionLabel('Source folder'),
              const SizedBox(height: 8),
              _PathRow(
                path: _sourceDir,
                placeholder: 'No folder selected',
                trailing: FilledButton.tonal(
                  onPressed: _pickSource,
                  child: const Text('Choose'),
                ),
              ),
              const SizedBox(height: 20),
              _SectionLabel('Destination (library root)'),
              const SizedBox(height: 8),
              _PathRow(path: destRoot, readOnly: true),
              const SizedBox(height: 32),
              Align(
                alignment: Alignment.centerRight,
                child: FilledButton.icon(
                  onPressed: canDiscover
                      ? () => ref
                          .read(organizerProvider.notifier)
                          .discover(_sourceDir!)
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

  // ── Discovering ───────────────────────────────────────────────────────────

  Widget _buildDiscovering(BuildContext context, OrganizerState state) {
    final theme = Theme.of(context);
    final dir = state.scanningDir;
    final label = dir != null ? 'Scanning $dir…' : 'Scanning folder…';

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const CircularProgressIndicator(),
            const SizedBox(height: 16),
            Text(label, style: theme.textTheme.bodyMedium),
            const SizedBox(height: 4),
            if (state.filesFound > 0)
              Text(
                '${state.filesFound} file${state.filesFound == 1 ? '' : 's'} found',
                style: theme.textTheme.bodySmall
                    ?.copyWith(color: context.colors.textSecondary),
              ),
          ],
        ),
      ),
    );
  }

  // ── Review ────────────────────────────────────────────────────────────────

  Widget _buildReview(BuildContext context, OrganizerState state) {
    final plan = state.plan!;
    final notifier = ref.read(organizerProvider.notifier);
    final total = plan.total;

    return Scaffold(
      body: Column(
        children: [
          _PreviewHeader(count: total, verb: 'sorted'),
          if (plan.errors.isNotEmpty) ...[
            const Divider(height: 1),
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
              child: _ErrorList(
                errors: plan.errors,
                title:
                    '${plan.errors.length} file${plan.errors.length == 1 ? '' : 's'} skipped during scan',
              ),
            ),
          ],
          const Divider(height: 1),
          Expanded(child: FolderTreePreview(tree: plan.tree)),
          const Divider(height: 1),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: notifier.reset,
                  child: const Text('Cancel'),
                ),
                const SizedBox(width: 12),
                FilledButton.icon(
                  onPressed: total == 0 ? null : notifier.apply,
                  icon: const Icon(Icons.drive_folder_upload_outlined),
                  label: Text(total == 0
                      ? 'No files to sort'
                      : 'Sort $total Photo${total == 1 ? '' : 's'}'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ── Applying ──────────────────────────────────────────────────────────────

  Widget _buildApplying(BuildContext context, OrganizerState state) {
    final theme = Theme.of(context);
    final errorCount = state.applyErrors.length;
    final processed = state.applied + errorCount;
    final fraction = state.total == 0 ? null : processed / state.total;

    return Scaffold(
      body: Center(
        child: SizedBox(
          width: 320,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Sorting photos…', style: theme.textTheme.titleMedium),
              const SizedBox(height: 16),
              LinearProgressIndicator(value: fraction),
              const SizedBox(height: 8),
              Row(
                children: [
                  Text('${state.applied} of ${state.total}'),
                  if (errorCount > 0) ...[
                    const SizedBox(width: 8),
                    Text(
                      '($errorCount skipped)',
                      style: theme.textTheme.bodySmall
                          ?.copyWith(color: context.colors.errorPrimary),
                    ),
                  ],
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ── Done ──────────────────────────────────────────────────────────────────

  Widget _buildDone(BuildContext context, OrganizerState state) {
    final theme = Theme.of(context);
    final notifier = ref.read(organizerProvider.notifier);
    final allErrors = [
      ...?state.plan?.errors,
      ...state.applyErrors,
    ];

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
                      size: 28, color: context.colors.primaryColor),
                  const SizedBox(width: 10),
                  Text(
                    '${state.applied} photo${state.applied == 1 ? '' : 's'} sorted',
                    style: theme.textTheme.headlineSmall
                        ?.copyWith(fontWeight: FontWeight.w600),
                  ),
                ],
              ),
              if (allErrors.isNotEmpty) ...[
                const SizedBox(height: 20),
                _ErrorList(
                  errors: allErrors,
                  title:
                      '${allErrors.length} file${allErrors.length == 1 ? '' : 's'} had errors',
                ),
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

  Widget _buildError(BuildContext context, OrganizerState state) {
    final theme = Theme.of(context);
    final notifier = ref.read(organizerProvider.notifier);

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.error_outline_rounded,
                size: 56, color: context.colors.errorPrimary),
            const SizedBox(height: 16),
            Text('Something went wrong', style: theme.textTheme.titleMedium),
            const SizedBox(height: 8),
            SizedBox(
              width: 360,
              child: Text(
                state.error ?? 'Unknown error',
                textAlign: TextAlign.center,
                style: theme.textTheme.bodySmall
                    ?.copyWith(color: context.colors.textSecondary),
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

  Widget _buildCentered(Widget icon, String label) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [icon, const SizedBox(height: 16), Text(label)],
        ),
      ),
    );
  }
}

// ── Private widgets ───────────────────────────────────────────────────────────

class _SectionLabel extends StatelessWidget {
  const _SectionLabel(this.text);

  final String text;

  @override
  Widget build(BuildContext context) => Text(
        text,
        style: Theme.of(context)
            .textTheme
            .labelMedium
            ?.copyWith(color: context.colors.textSecondary),
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

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        color: context.colors.surfacePrimary,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: context.colors.borderPrimary),
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
            color: path != null
                ? context.colors.primaryColor
                : context.colors.borderPrimary,
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              path ?? placeholder ?? '',
              style: theme.textTheme.bodySmall?.copyWith(
                color: path != null
                    ? context.colors.textPrimary
                    : context.colors.borderPrimary,
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

class _PreviewHeader extends StatelessWidget {
  const _PreviewHeader({required this.count, required this.verb});

  final int count;
  final String verb;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 16, 20, 12),
      child: Row(
        children: [
          Icon(Icons.drive_folder_upload_outlined,
              size: 20, color: context.colors.primaryColor),
          const SizedBox(width: 10),
          Expanded(
            child: count == 0
                ? Text('No media files found',
                    style: theme.textTheme.titleSmall)
                : Text.rich(
                    TextSpan(
                      text: '$count photo${count == 1 ? '' : 's'}',
                      style: theme.textTheme.titleSmall
                          ?.copyWith(fontWeight: FontWeight.w600),
                      children: [
                        TextSpan(
                          text: ' will be $verb into your library',
                          style: theme.textTheme.titleSmall
                              ?.copyWith(fontWeight: FontWeight.normal),
                        ),
                      ],
                    ),
                  ),
          ),
        ],
      ),
    );
  }
}

class _ErrorList extends StatefulWidget {
  const _ErrorList({required this.errors, required this.title});

  final List<DiscoveryError> errors;
  final String title;

  @override
  State<_ErrorList> createState() => _ErrorListState();
}

class _ErrorListState extends State<_ErrorList> {
  bool _expanded = false;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: context.colors.errorSurface,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
            color: context.colors.errorPrimary.withValues(alpha: 0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GestureDetector(
            onTap: () => setState(() => _expanded = !_expanded),
            child: Row(
              children: [
                Icon(Icons.warning_amber_rounded,
                    size: 16, color: context.colors.errorPrimary),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    widget.title,
                    style: theme.textTheme.bodySmall
                        ?.copyWith(color: context.colors.errorPrimary),
                  ),
                ),
                Icon(
                  _expanded ? Icons.expand_less : Icons.expand_more,
                  size: 16,
                  color: context.colors.errorPrimary,
                ),
              ],
            ),
          ),
          if (_expanded) ...[
            const SizedBox(height: 8),
            ConstrainedBox(
              constraints: const BoxConstraints(maxHeight: 160),
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: widget.errors.length,
                itemBuilder: (_, i) {
                  final err = widget.errors[i];
                  return Padding(
                    padding: const EdgeInsets.only(top: 6),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Text(
                            err.filename,
                            style: theme.textTheme.bodySmall?.copyWith(
                              color: context.colors.textPrimary,
                              fontFamily: 'monospace',
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Text(
                          err.reason,
                          style: theme.textTheme.bodySmall?.copyWith(
                            color: context.colors.textSecondary,
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ],
      ),
    );
  }
}
