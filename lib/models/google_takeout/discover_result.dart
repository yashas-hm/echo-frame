part of 'takeout_models.dart';

class DiscoverResult {
  final List<MatchedPair> pairs;
  final List<ImportError> unmatched;

  const DiscoverResult({required this.pairs, required this.unmatched});

  int get withSidecar => pairs.where((p) => p.hasMeta).length;

  int get withoutSidecar => pairs.where((p) => !p.hasMeta).length;
}
