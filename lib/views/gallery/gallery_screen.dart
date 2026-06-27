
import 'package:echo_frame/models/media/media.dart' show MediaItem;
import 'package:echo_frame/views/gallery/components/actions_tray.dart';
import 'package:echo_frame/views/gallery/components/caret_arrows.dart';
import 'package:echo_frame/views/gallery/components/gallery_info_panel.dart';
import 'package:echo_frame/views/gallery/image_view.dart';
import 'package:echo_frame/views/gallery/video_view.dart';
import 'package:echo_frame/views/media/provider/media_collection_notifier.dart';
import 'package:echo_frame/views/media/favourites/favorites_screen.dart'
    show favoritesProvider;
import 'package:echo_frame/views/media/timeline/timeline_screen.dart'
    show timelineProvider;
import 'package:echo_frame/views/media/trash/trash_screen.dart'
    show trashProvider;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:media_kit/media_kit.dart' show Player;

class GalleryScreen extends ConsumerStatefulWidget {
  const GalleryScreen({
    super.key,
    required this.initialMediaId,
    required this.source,
  });

  final String initialMediaId;
  final MediaCollectionSource source;

  static const String path = '/gallery';

  static GoRoute get routeDef => GoRoute(
        path: path,
        builder: (_, state) {
          final (id, source) = state.extra as (String, MediaCollectionSource);
          return GalleryScreen(initialMediaId: id, source: source);
        },
      );

  @override
  ConsumerState<GalleryScreen> createState() => _GalleryScreenState();
}

class _GalleryScreenState extends ConsumerState<GalleryScreen> {
  AsyncNotifierProvider<MediaCollectionNotifier, MediaCollectionState>
      get _provider => switch (widget.source) {
            MediaCollectionSource.favorites => favoritesProvider,
            MediaCollectionSource.trash => trashProvider,
            MediaCollectionSource.timeline => timelineProvider,
          };

  int _currentIndex = 0;
  bool _showInfo = false;

  Player? _player;
  final _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    // TODO: O(n) scan — consider an id→index map on MediaCollectionState
    final flat = ref.read(_provider).value?.flatItems ?? const [];
    _currentIndex = flat.indexWhere((item) => item.id == widget.initialMediaId);
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  void _goNext() {
    final state = ref.read(_provider).value;
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
        (_) => ref.read(_provider.notifier).loadNextPage(),
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

  void _toggleInfoPanel() {
    setState(() => _showInfo = !_showInfo);
    if (!_showInfo) _focusNode.requestFocus();
  }

  void _onItemRestored(String itemId) {
    if (!mounted) return;
    // TODO: O(n) scan — consider an id→index map on MediaCollectionState
    final flat = ref.read(_provider).value?.flatItems ?? [];
    final idx = flat.indexWhere((i) => i.id == itemId);
    if (idx != -1) setState(() => _currentIndex = idx);
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(_provider).requireValue;
    final flat = state.flatItems;

    if (flat.isEmpty) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted) context.pop();
      });
      return const SizedBox.shrink();
    }

    if (_currentIndex >= flat.length) _currentIndex = flat.length - 1;
    _checkLoadRequired(state, flat);
    final canPrev = _currentIndex > 0;
    final canNext = _currentIndex < flat.length - 1 || state.hasMore;
    final item = flat[_currentIndex];

    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: CallbackShortcuts(
              bindings: {
                if (!_showInfo)
                  const SingleActivator(LogicalKeyboardKey.arrowRight): _goNext,
                if (!_showInfo)
                  const SingleActivator(LogicalKeyboardKey.arrowLeft): _goPrev,
                const SingleActivator(
                  LogicalKeyboardKey.escape,
                  includeRepeats: false,
                ): _showInfo ? _toggleInfoPanel : context.pop,
                if (!_showInfo)
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
                ): _toggleInfoPanel,
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
                              onClosePressed: _toggleInfoPanel,
                            )
                          : SizedBox.shrink(),
                    ),
                  ],
                ),
              ),
            ),
          ),
          if (canPrev) CaretArrow(left: true, onPressed: _goPrev),
          if (canNext && !_showInfo)
            CaretArrow(
              left: false,
              onPressed: _goNext,
              loadingNext: state.isLoadingMore,
            ),
          if (!_showInfo)
            ActionsTray(
              item: item,
              onInfoPressed: _toggleInfoPanel,
              onItemRestored: _onItemRestored,
            ),
        ],
      ),
    );
  }
}
