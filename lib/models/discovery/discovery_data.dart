part of 'discovery.dart';

class DiscoveryData {
  const DiscoveryData({
    required this.mediaPath,
    required this.destPath,
    required this.meta,
  });

  final String mediaPath;
  final String destPath;
  final Metadata meta;

  String get filename => mediaPath.split('/').last;
}
