import 'package:echo_frame/utilities/utilities.dart'
    show ContextExtensions, SearchIntent;
import 'package:echo_frame/views/shell/components/title_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class EmptyShell extends ConsumerWidget {
  const EmptyShell({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Actions(
      actions: {
        SearchIntent: CallbackAction<SearchIntent>(
          onInvoke: (_) {
            SearchIntent.handle(context, ref);
            return null;
          },
        ),
      },
      child: Scaffold(
        backgroundColor: context.colors.background,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const TitleBar(),
            Expanded(child: child),
          ],
        ),
      ),
    );
  }
}
