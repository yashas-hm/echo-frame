part of 'takeout_models.dart';

class ImportError {
  final String path;
  final String reason;

  const ImportError({required this.path, required this.reason});

  String get filename => path.split('/').last;
}
