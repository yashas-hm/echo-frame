part of 'takeout_models.dart';

class MatchedPair {
  final String mediaPath;
  final String? sidecarPath;
  final TakeoutSidecar? meta;

  const MatchedPair({
    required this.mediaPath,
    this.sidecarPath,
    this.meta,
  });

  String get filename => mediaPath.split('/').last;

  bool get hasMeta => meta != null;
}
