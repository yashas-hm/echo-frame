class OperationResult {
  final String sourcePath;
  final String destPath;
  final String destRelative; // e.g. "2021/January/photo.jpg"
  final bool hasConflict;

  const OperationResult({
    required this.sourcePath,
    required this.destPath,
    required this.destRelative,
    this.hasConflict = false,
  });

  String get filename => sourcePath.split('/').last;
  String get destFilename => destRelative.split('/').last;
  String get monthKey => destRelative.split('/').take(2).join('/');
}