part of 'import.dart';

class ImportProgress {
  const ImportProgress({
    required this.imported,
    required this.total,
    this.currentFile,
    this.errors = const [],
  });

  final int imported;
  final int total;
  final String? currentFile;
  final List<DiscoveryError> errors;

  int get processed => imported + errors.length;

  double get fraction => total == 0 ? 1.0 : processed / total;
}
