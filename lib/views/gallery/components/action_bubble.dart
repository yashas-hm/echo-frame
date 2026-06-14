import 'package:echo_frame/utilities/utilities.dart' show ContextExtension;
import 'package:flutter/material.dart';

class ActionBubble {
  static void show(BuildContext context, {required IconData icon}) {
    final overlay = Overlay.of(context);
    late OverlayEntry entry;

    entry = OverlayEntry(
      builder: (_) => _ActionBubbleToast(
        icon: icon,
        onDismissed: entry.remove,
      ),
    );

    overlay.insert(entry);
  }
}

class _ActionBubbleToast extends StatefulWidget {
  const _ActionBubbleToast({
    required this.icon,
    required this.onDismissed,
  });

  final IconData icon;
  final VoidCallback onDismissed;

  @override
  State<_ActionBubbleToast> createState() => _ActionBubbleToastState();
}

class _ActionBubbleToastState extends State<_ActionBubbleToast>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 250),
    );
    _run();
  }

  Future<void> _run() async {
    await _controller.forward();
    await Future.delayed(const Duration(milliseconds: 500));
    if (!mounted) return;
    await _controller.reverse();
    if (!mounted) return;
    widget.onDismissed();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      child: Center(
        child: FadeTransition(
          opacity: _controller,
          child: DecoratedBox(
            decoration: BoxDecoration(
              color: context.colors.surfacePrimary.withValues(alpha: 0.4),
              shape: BoxShape.circle,
            ),
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Icon(widget.icon, size: 32),
            ),
          ),
        ),
      ),
    );
  }
}
