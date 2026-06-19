part of 'utilities.dart';

class DeleteIntent extends Intent {
  const DeleteIntent();
}

class SearchIntent extends Intent {
  const SearchIntent();

  static void handle(BuildContext context, WidgetRef ref) {
    final location = GoRouterState.of(context).matchedLocation;
    if (location != TimelineScreen.path) {
      context.go(TimelineScreen.path);
      WidgetsBinding.instance.addPostFrameCallback(
            (_) => ref.read(timelineSearchFocusProvider).requestFocus(),
      );
    }else{
      ref.read(timelineSearchFocusProvider).requestFocus();
    }
  }
}
