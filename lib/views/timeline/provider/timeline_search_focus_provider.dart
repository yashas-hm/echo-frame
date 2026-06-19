import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final timelineSearchFocusProvider = Provider<FocusNode>((ref) {
  final node = FocusNode();
  ref.onDispose(node.dispose);
  return node;
});