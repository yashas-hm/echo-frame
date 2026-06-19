// import 'package:echo_frame/models/organizer_result.dart';
// import 'package:echo_frame/utilities/utilities.dart' show ContextExtension;
// import 'package:flutter/material.dart';
//
// class OperationPreviewList extends StatelessWidget {
//   const OperationPreviewList({super.key, required this.operations});
//
//   final List<OperationResult> operations;
//
//   @override
//   Widget build(BuildContext context) {
//     final theme = Theme.of(context);
//
//     if (operations.isEmpty) {
//       return Center(
//         child: Column(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             Icon(Icons.folder_off_outlined,
//                 size: 48, color: context.colors.borderPrimary),
//             const SizedBox(height: 16),
//             Text('No media files found in the selected folder',
//                 style: theme.textTheme.bodyMedium
//                     ?.copyWith(color: context.colors.textSecondary)),
//           ],
//         ),
//       );
//     }
//
//     // Group by month key ("2021/January")
//     final groups = <String, List<OperationResult>>{};
//     for (final op in operations) {
//       (groups[op.monthKey] ??= []).add(op);
//     }
//
//     return ListView(
//       children: [
//         for (final entry in groups.entries) ...[
//           Padding(
//             padding: const EdgeInsets.fromLTRB(16, 16, 16, 4),
//             child: Text(
//               entry.key,
//               style: theme.textTheme.labelSmall?.copyWith(
//                 color: context.colors.textSecondary,
//                 fontWeight: FontWeight.w600,
//                 letterSpacing: 0.6,
//               ),
//             ),
//           ),
//           const Divider(height: 1, indent: 16),
//           for (final op in entry.value)
//             ListTile(
//               dense: true,
//               leading: Icon(
//                 op.hasConflict
//                     ? Icons.drive_file_rename_outline_rounded
//                     : Icons.subdirectory_arrow_right_rounded,
//                 size: 16,
//                 color: op.hasConflict
//                     ? context.colors.surfacePrimary
//                     : context.colors.primaryColor,
//               ),
//               title: Text(
//                 op.filename,
//                 style: theme.textTheme.bodySmall,
//                 overflow: TextOverflow.ellipsis,
//               ),
//               subtitle: op.hasConflict
//                   ? Text(
//                       'Renamed → ${op.destFilename}',
//                       style: theme.textTheme.bodySmall
//                           ?.copyWith(color: context.colors.surfacePrimary),
//                     )
//                   : null,
//             ),
//         ],
//       ],
//     );
//   }
// }
