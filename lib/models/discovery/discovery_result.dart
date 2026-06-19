part of 'discovery.dart';

class DiscoveryResult {
  const DiscoveryResult({
    required this.items,
    required this.tree,
    this.errors = const [],
  });

  final List<DiscoveryData> items;
  final FolderTree tree;
  final List<DiscoveryError> errors;

  int get total => items.length;
}
