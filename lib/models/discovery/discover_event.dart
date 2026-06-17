part of 'discovery.dart';

sealed class DiscoverEvent {}

class DiscoverScanning extends DiscoverEvent {
  DiscoverScanning({required this.dirName, required this.filesFound});

  final String dirName;
  final int filesFound;
}

class DiscoverDone extends DiscoverEvent {
  DiscoverDone({required this.plan});

  final DiscoveryResult plan;
}
