import 'package:echo_frame/models/folder_tree.dart';
import 'package:echo_frame/utilities/utilities.dart' show ContextExtension;
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class FolderTreePreview extends StatelessWidget {
  const FolderTreePreview({super.key, required this.tree});

  final FolderTree tree;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    if (tree.isEmpty) {
      return Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.folder_off_outlined,
                size: 48, color: context.colors.borderPrimary),
            const SizedBox(height: 16),
            Text(
              'No media files found',
              style: theme.textTheme.bodyMedium
                  ?.copyWith(color: context.colors.textSecondary),
            ),
          ],
        ),
      );
    }

    final years = tree.sortedYears;
    final monthFmt = DateFormat('MMMM');

    return ListView.builder(
      itemCount: years.length,
      itemBuilder: (_, i) {
        final year = years[i];
        final months = tree.sortedMonthsFor(year);
        final yearTotal = tree.yearTotal(year);

        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: EdgeInsets.fromLTRB(20, i == 0 ? 20 : 16, 20, 6),
              child: Row(
                children: [
                  Icon(Icons.folder_rounded,
                      size: 14, color: context.colors.primaryColor),
                  const SizedBox(width: 8),
                  Text(
                    '$year',
                    style: theme.textTheme.labelMedium?.copyWith(
                      fontWeight: FontWeight.w700,
                      color: context.colors.textPrimary,
                    ),
                  ),
                  const Spacer(),
                  Text(
                    '$yearTotal',
                    style: theme.textTheme.labelSmall
                        ?.copyWith(color: context.colors.textSecondary),
                  ),
                ],
              ),
            ),
            const Divider(height: 1, indent: 20, endIndent: 20),
            for (final entry in months)
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 9),
                child: Row(
                  children: [
                    const SizedBox(width: 22),
                    Text(
                      monthFmt.format(DateTime(year, entry.key)),
                      style: theme.textTheme.bodySmall
                          ?.copyWith(color: context.colors.textPrimary),
                    ),
                    const Spacer(),
                    Text(
                      '${entry.value}',
                      style: theme.textTheme.bodySmall
                          ?.copyWith(color: context.colors.textSecondary),
                    ),
                  ],
                ),
              ),
          ],
        );
      },
    );
  }
}