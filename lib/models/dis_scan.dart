class DirScan {
  const DirScan({
    required this.dirName,
    required this.mediaPaths,
    required this.jsonByName,
  });

  final String dirName;
  final List<String> mediaPaths;

  /// JSON files in this directory keyed by filename — for sidecar lookup.
  final Map<String, String> jsonByName;
}
