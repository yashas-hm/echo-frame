part of 'discovery.dart';

class DiscoveryError {
  const DiscoveryError({required this.sourcePath, required this.reason});

  final String sourcePath;
  final String reason;

  String get filename => sourcePath.split('/').last;
}
