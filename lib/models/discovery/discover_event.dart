part of 'discovery.dart';

sealed class DiscoverEvent {}

class DiscoverScanning extends DiscoverEvent {
  DiscoverScanning({required this.dirName, required this.filesFound});

  final String dirName;
  final int filesFound;
}

class DiscoverTakeoutSideCar extends DiscoverScanning{
  DiscoverTakeoutSideCar({required super.dirName, required super.filesFound});
}

class DiscoverReading extends DiscoverEvent {
  DiscoverReading({required this.done, required this.total, this.result});

  final int done;
  final int total;

  /// Null on intermediate progress events; the completed map on the final event.
  final Map<String, Metadata>? result;
}

class DiscoverDone extends DiscoverEvent {
  DiscoverDone({required this.plan});

  final DiscoveryResult plan;
}
