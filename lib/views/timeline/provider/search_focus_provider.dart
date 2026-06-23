import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final searchFocusProvider = Provider<FocusNode>((ref) {
  final node = FocusNode();
  ref.onDispose(node.dispose);
  return node;
});
