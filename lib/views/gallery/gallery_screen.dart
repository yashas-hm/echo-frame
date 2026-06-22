import 'package:echo_frame/components/error_view.dart';
import 'package:echo_frame/models/media_item.dart';
import 'package:echo_frame/views/gallery/components/actions_tray.dart';
import 'package:echo_frame/views/gallery/components/caret_arrows.dart';
import 'package:echo_frame/views/gallery/components/gallery_info_panel.dart';
import 'package:echo_frame/views/gallery/image_view.dart';
import 'package:echo_frame/views/gallery/video_view.dart';
import 'package:echo_frame/views/timeline/provider/timeline_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:media_kit/media_kit.dart' show Player;

class GalleryScreen extends ConsumerStatefulWidget {
  const GalleryScreen({super.key, required this.initialMediaId});

  final String initialMediaId;

  static const String path = '/gallery';

  static GoRoute get routeDef => GoRoute(
        path: path,
        builder: (_, state) => GalleryScreen(
          initialMediaId: state.extra as String,
        ),
      );

  @override
  ConsumerState<GalleryScreen> createState() => _GalleryScreenState();
}

class _GalleryScreenState extends ConsumerState<GalleryScreen> {
  int _currentIndex = 0;
  bool _showInfo = false;

  Player? _player;
  final _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    final flat = ref.read(timelineProvider).value?.flatItems ?? const [];
    _currentIndex = flat.indexWhere((item) => item.id == widget.initialMediaId);
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  void _goNext() {
    final state = ref.read(timelineProvider).value;
    if (state == null) return;
    _player?.stop();
    if (_currentIndex < state.flatItems.length - 1) {
      setState(() {
        _player = null;
        _currentIndex++;
      });
      WidgetsBinding.instance
          .addPostFrameCallback((_) => _focusNode.requestFocus());
    }
  }

  void _checkLoadRequired(MediaCollectionState state, List<MediaItem> flat) {
    if (!state.hasMore || state.isLoadingMore) return;
    if (flat.length - 1 - _currentIndex <= 10) {
      WidgetsBinding.instance.addPostFrameCallback(
        (_) => ref.read(timelineProvider.notifier).loadNextPage(),
      );
    }
  }

  void _goPrev() {
    _player?.stop();
    if (_currentIndex > 0) {
      setState(() {
        _player = null;
        _currentIndex--;
      });
      WidgetsBinding.instance
          .addPostFrameCallback((_) => _focusNode.requestFocus());
    }
  }

  void _showInfoF() => setState(() => _showInfo = !_showInfo);

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(timelineProvider).requireValue;
    final flat = state.flatItems;
    final validIndex = _currentIndex >= 0 && _currentIndex < flat.length;

    if (validIndex) _checkLoadRequired(state, flat);
    final canPrev = validIndex && _currentIndex > 0;
    final canNext =
        validIndex && (_currentIndex < flat.length - 1 || state.hasMore);
    final item = flat[_currentIndex];

    return Stack(
      children: [
        Positioned.fill(
          child: !validIndex
              ? ErrorView(
                  errorMessage: 'Something went wrong',
                  description: 'This photo could not be found. '
                      'It may have been removed or the library reloaded.',
                  buttonText: 'Reload',
                  onButtonPressed: () => setState(
                    () =>
                        _currentIndex = _currentIndex.clamp(0, flat.length - 1),
                  ),
                )
              : CallbackShortcuts(
                  bindings: {
                    const SingleActivator(LogicalKeyboardKey.arrowRight):
                        _goNext,
                    const SingleActivator(LogicalKeyboardKey.arrowLeft):
                        _goPrev,
                    const SingleActivator(
                      LogicalKeyboardKey.escape,
                      includeRepeats: false,
                    ): context.pop,
                    const SingleActivator(
                      LogicalKeyboardKey.space,
                      includeRepeats: false,
                    ): () => VideoControlFunctions.togglePlayPause(
                          context,
                          _player,
                        ),
                    const SingleActivator(
                      LogicalKeyboardKey.keyI,
                      includeRepeats: false,
                    ): _showInfoF,
                    const SingleActivator(
                      LogicalKeyboardKey.keyM,
                      includeRepeats: false,
                    ): () => VideoControlFunctions.toggleMute(
                          context,
                          _player,
                        ),
                  },
                  child: Focus(
                    focusNode: _focusNode,
                    autofocus: true,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                          child: AnimatedSwitcher(
                            duration: Durations.medium2,
                            child: KeyedSubtree(
                              key: ValueKey(_currentIndex),
                              child: item.isVideo
                                  ? VideoView(
                                      item: item,
                                      onPlayerReady: (p) {
                                        if (p == null) return;
                                        WidgetsBinding.instance
                                            .addPostFrameCallback(
                                          (_) => setState(() => _player = p),
                                        );
                                      },
                                    )
                                  : ImageView(item: item),
                            ),
                          ),
                        ),
                        AnimatedSize(
                          duration: Durations.short4,
                          child: _showInfo
                              ? GalleryInfoPanel(
                                  item: item,
                                  onClosePressed: _showInfoF,
                                )
                              : SizedBox.shrink(),
                        ),
                      ],
                    ),
                  ),
                ),
        ),
        if (canPrev) CaretArrow(left: true, onPressed: _goPrev),
        if (canNext)
          CaretArrow(
            left: false,
            onPressed: _goNext,
            loadingNext: state.isLoadingMore,
          ),
        if (!_showInfo)
          ActionsTray(
            item: item,
            onInfoPressed: _showInfoF,
          ),
      ],
    );
  }
}
