import 'package:echo_frame/models/google_takeout/takeout_models.dart';
import 'package:echo_frame/theme/theme.dart';
import 'package:flutter/material.dart';

class ImportReport extends StatefulWidget {
  const ImportReport({super.key, required this.unmatched});

  final List<ImportError> unmatched;

  @override
  State<ImportReport> createState() => _ImportReportState();
}

class _ImportReportState extends State<ImportReport> {
  bool _expanded = false;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    if (widget.unmatched.isEmpty) return const SizedBox.shrink();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        InkWell(
          onTap: () => setState(() => _expanded = !_expanded),
          borderRadius: BorderRadius.circular(8),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: Row(
              children: [
                Icon(
                  Icons.warning_amber_rounded,
                  size: 16,
                  color: context.colors.tertiaryColor,
                ),
                const SizedBox(width: 8),
                Text(
                  '${widget.unmatched.length} sidecar${widget.unmatched.length == 1 ? '' : 's'} '
                  'with no matching file',
                  style: theme.textTheme.bodySmall
                      ?.copyWith(color: context.colors.tertiaryColor),
                ),
                const Spacer(),
                Icon(
                  _expanded
                      ? Icons.expand_less_rounded
                      : Icons.expand_more_rounded,
                  size: 16,
                  color: context.colors.textSecondary,
                ),
              ],
            ),
          ),
        ),
        if (_expanded) ...[
          const SizedBox(height: 4),
          Container(
            constraints: const BoxConstraints(maxHeight: 200),
            decoration: BoxDecoration(
              color: context.colors.tertiaryColor,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: context.colors.borderPrimary),
            ),
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(vertical: 4),
              itemCount: widget.unmatched.length,
              itemBuilder: (_, i) {
                final err = widget.unmatched[i];
                return Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
                  child: Row(
                    children: [
                      Icon(Icons.insert_drive_file_outlined,
                          size: 13, color: context.colors.borderPrimary),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          err.filename,
                          style: theme.textTheme.bodySmall,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        err.reason,
                        style: theme.textTheme.bodySmall
                            ?.copyWith(color: context.colors.textSecondary),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ],
    );
  }
}
