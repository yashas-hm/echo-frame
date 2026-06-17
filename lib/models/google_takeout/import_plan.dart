import 'package:echo_frame/models/folder_tree.dart';
import 'package:echo_frame/models/google_takeout/discovery_error.dart';
import 'package:echo_frame/models/google_takeout/planned_import.dart';

class ImportPlan {
  const ImportPlan({
    required this.items,
    required this.tree,
    this.errors = const [],
  });

  final List<PlannedImport> items;
  final FolderTree tree;
  final List<DiscoveryError> errors;

  int get total => items.length;
}