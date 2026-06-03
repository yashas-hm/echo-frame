import 'package:echo_frame/models/google_takeout/takeout_meta.dart';

class MatchedPair {
  final String mediaPath;
  final String? sidecarPath;
  final TakeoutMeta? meta;

  const MatchedPair({
    required this.mediaPath,
    this.sidecarPath,
    this.meta,
  });

  String get filename => mediaPath.split('/').last;

  bool get hasMeta => meta != null;
}

class ImportError {
  final String path;
  final String reason;

  const ImportError({required this.path, required this.reason});

  String get filename => path.split('/').last;
}

class DiscoverResult {
  final List<MatchedPair> pairs;
  final List<ImportError> unmatched;

  const DiscoverResult({required this.pairs, required this.unmatched});

  int get withSidecar => pairs.where((p) => p.hasMeta).length;

  int get withoutSidecar => pairs.where((p) => !p.hasMeta).length;
}
