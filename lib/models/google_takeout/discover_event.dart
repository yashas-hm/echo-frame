import 'package:echo_frame/models/google_takeout/import_plan.dart';

sealed class DiscoverEvent {}

class DiscoverScanning extends DiscoverEvent {
  DiscoverScanning({required this.dirName, required this.filesFound});

  final String dirName;
  final int filesFound;
}

class DiscoverDone extends DiscoverEvent {
  DiscoverDone({required this.plan});

  final ImportPlan plan;
}
