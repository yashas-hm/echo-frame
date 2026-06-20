import 'package:echo_frame/components/buttons/buttons.dart';
import 'package:echo_frame/views/gallery/components/caret_arrows.dart';
import 'package:echo_frame/views/gallery/image_view.dart';
import 'package:echo_frame/views/gallery/video_view.dart';
import 'package:echo_frame/views/timeline/provider/timeline_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:media_kit/media_kit.dart';

import 'components/action_bubble.dart';
import 'components/gallery_info_panel.dart';

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

  bool _loadingNext = false;
  bool _showInfo = false;

  Player? _player;

  @override
  void initState() {
    super.initState();
    final flat = ref.read(timelineProvider).value?.flatItems ?? const [];
    _currentIndex = flat.indexWhere((item) => item.id == widget.initialMediaId);
  }

  void _goNext() {
    final state = ref.read(timelineProvider).value;
    if (state == null) return;
    _player?.stop();
    if (_currentIndex < state.flatItems.length - 1) {
      setState(() => _currentIndex++);
    } else if (state.hasMore) {
      setState(() => _loadingNext = true);
      ref.read(timelineProvider.notifier).loadNextPage();
    }
  }

  void _goPrev() {
    _player?.stop();
    if (_currentIndex > 0) setState(() => _currentIndex--);
  }

  void _togglePlayPause() {
    final player = _player;
    if (player == null) return;
    player.playOrPause();
    ActionBubble.show(
      context,
      icon:
          player.state.playing ? Icons.pause_rounded : Icons.play_arrow_rounded,
    );
  }

  void _toggleMute() {
    final player = _player;
    if (player == null) return;
    if (player.state.volume <= 0) {
      player.setVolume(100);
      ActionBubble.show(context, icon: Icons.volume_up_rounded);
    } else {
      player.setVolume(0);
      ActionBubble.show(context, icon: Icons.volume_off_rounded);
    }
  }

  @override
  Widget build(BuildContext context) {
    ref.listen(
      timelineProvider,
      (_, next) {
        if (!_loadingNext) return;
        final flat = next.value?.flatItems ?? const [];
        if (_currentIndex < flat.length - 1) {
          setState(() {
            _loadingNext = false;
            _currentIndex++;
          });
        }
      },
    );

    final timelineAsync = ref.watch(timelineProvider);

    return timelineAsync.when(
      loading: () => _scaffold(
        child: const Center(child: CircularProgressIndicator()),
      ),
      error: (e, _) => _scaffold(
        child: Center(child: Text('Error: $e')),
      ),
      data: (state) {
        final flat = state.flatItems;

        if (_currentIndex < 0 || _currentIndex >= flat.length) {
          return _scaffold(
            child: const Center(child: CircularProgressIndicator()),
          );
        }

        final item = flat[_currentIndex];
        final canPrev = _currentIndex > 0;
        final canNext = _currentIndex < flat.length - 1 || state.hasMore;

        return _scaffold(
          canPrev: canPrev,
          canNext: canNext,
          child: CallbackShortcuts(
            bindings: {
              const SingleActivator(LogicalKeyboardKey.arrowRight): _goNext,
              const SingleActivator(LogicalKeyboardKey.arrowLeft): _goPrev,
              const SingleActivator(
                LogicalKeyboardKey.escape,
                includeRepeats: false,
              ): context.pop,
              const SingleActivator(
                LogicalKeyboardKey.space,
                includeRepeats: false,
              ): _togglePlayPause,
              const SingleActivator(
                LogicalKeyboardKey.keyI,
                includeRepeats: false,
              ): () => setState(() => _showInfo = !_showInfo),
              const SingleActivator(
                LogicalKeyboardKey.keyM,
                includeRepeats: false,
              ): _toggleMute,
            },
            child: Focus(
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
                                onPlayerReady: (p) => _player = p,
                              )
                            : ImageView(item: item),
                      ),
                    ),
                  ),
                  AnimatedSize(
                    duration: Durations.short4,
                    child: _showInfo
                        ? GalleryInfoPanel(item: item)
                        : SizedBox.shrink(),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _scaffold({
    required Widget child,
    bool canPrev = false,
    bool canNext = false,
  }) {
    return Stack(
      children: [
        Positioned.fill(child: child),
        if (canPrev)
          CaretArrow(
            left: true,
            onPressed: _goPrev,
          ),
        if (canNext)
          CaretArrow(
            left: false,
            onPressed: _goNext,
            loadingNext: _loadingNext,
          ),
        const EFBackButton(),
      ],
    );
  }
}
