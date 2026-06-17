import 'package:echo_frame/models/folder_tree.dart';
import 'package:echo_frame/models/google_takeout/planned_import.dart';

class ImportPlan {
  const ImportPlan({
    required this.items,
    required this.tree,
  });

  final List<PlannedImport> items;
  final FolderTree tree;

  int get total => items.length;
}
