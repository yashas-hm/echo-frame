import 'package:echo_frame/models/metadata.dart';

class PlannedImport {
  const PlannedImport({
    required this.mediaPath,
    required this.destPath,
    required this.meta,
  });

  final String mediaPath;
  final String destPath;
  final Metadata meta;

  String get filename => mediaPath.split('/').last;
}