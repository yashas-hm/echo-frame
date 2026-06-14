import 'package:echo_frame/theme/theme.dart';
import 'package:echo_frame/views/gallery/image_view.dart';
import 'package:echo_frame/views/gallery/video_view.dart';
import 'package:echo_frame/views/timeline/provider/timeline_provider.dart';
import 'package:echo_frame/widgets/title_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:media_kit/media_kit.dart';
import 'package:go_router/go_router.dart';

class GalleryScreen extends ConsumerStatefulWidget {
  const GalleryScreen({super.key, required this.mediaId});

  final int mediaId;

  static const String path = '/gallery';

  static GoRoute get routeDef => GoRoute(
        path: path,
        builder: (_, state) => GalleryScreen(
          mediaId: state.extra as int,
        ),
      );

  @override
  ConsumerState<GalleryScreen> createState() => _GalleryScreenState();
}

class _GalleryScreenState extends ConsumerState<GalleryScreen> {
  late int _currentIndex;
  bool _pendingNext = false;
  bool _hoverLeft = false;
  bool _hoverRight = false;
  Player? _player;

  static const double _zoneWidth = 80;

  @override
  void initState() {
    super.initState();
    final flat = ref.read(timelineProvider).value?.flatItems ?? const [];
    _currentIndex = flat.indexWhere((item) => item.id == widget.mediaId);
  }

  void _goNext() {
    final state = ref.read(timelineProvider).value;
    if (state == null) return;
    if (_currentIndex < state.flatItems.length - 1) {
      setState(() => _currentIndex++);
    } else if (state.hasMore) {
      setState(() => _pendingNext = true);
      ref.read(timelineProvider.notifier).loadNextPage();
    }
  }

  void _goPrev() {
    if (_currentIndex > 0) setState(() => _currentIndex--);
  }

  @override
  Widget build(BuildContext context) {
    ref.listen(
      timelineProvider,
      (_, next) {
        if (!_pendingNext) return;
        final flat = next.value?.flatItems ?? const [];
        if (_currentIndex < flat.length - 1) {
          setState(() {
            _pendingNext = false;
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
              const SingleActivator(LogicalKeyboardKey.escape, includeRepeats: false):
                  context.pop,
              const SingleActivator(LogicalKeyboardKey.space, includeRepeats: false):
                  () => _player?.playOrPause(),
            },
            child: Focus(
              autofocus: true,
              child: item.isVideo
                  ? VideoView(
                      item: item,
                      onPlayerReady: (p) => _player = p,
                    )
                  : ImageView(item: item),
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
    return Scaffold(
      backgroundColor: KnownColors.basicBlack,
      body: Column(
        children: [
          const TitleBar(),
          Expanded(
            child: Stack(
              children: [
                Positioned.fill(child: child),
                if (canPrev) _edgeZone(left: true),
                if (canNext) _edgeZone(left: false),
                Positioned(
                  top: 12,
                  left: 12,
                  child: _GalleryIconButton(
                    icon: Icons.arrow_back_rounded,
                    onPressed: context.pop,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _edgeZone({required bool left}) {
    final hovered = left ? _hoverLeft : _hoverRight;
    return Positioned(
      left: left ? 0 : null,
      right: left ? null : 0,
      top: 0,
      bottom: 0,
      width: _zoneWidth,
      child: MouseRegion(
        onEnter: (_) =>
            setState(() => left ? _hoverLeft = true : _hoverRight = true),
        onExit: (_) =>
            setState(() => left ? _hoverLeft = false : _hoverRight = false),
        child: AnimatedOpacity(
          opacity: hovered ? 1.0 : 0.0,
          duration: const Duration(milliseconds: 150),
          child: IgnorePointer(
            ignoring: !hovered,
            child: Center(
              child: _pendingNext && !left
                  ? const _LoadingArrow()
                  : _GalleryIconButton(
                      icon: left
                          ? Icons.arrow_back_ios_rounded
                          : Icons.arrow_forward_ios_rounded,
                      onPressed: left ? _goPrev : _goNext,
                    ),
            ),
          ),
        ),
      ),
    );
  }
}

class _LoadingArrow extends StatelessWidget {
  const _LoadingArrow();

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: KnownColors.basicBlack.withValues(alpha: 0.45),
        shape: BoxShape.circle,
      ),
      child: const SizedBox(
        width: 48,
        height: 48,
        child: Center(
          child: SizedBox(
            width: 20,
            height: 20,
            child: CircularProgressIndicator(
              strokeWidth: 2,
              color: KnownColors.basicWhite,
            ),
          ),
        ),
      ),
    );
  }
}

class _GalleryIconButton extends StatelessWidget {
  const _GalleryIconButton({required this.icon, required this.onPressed});

  final IconData icon;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: KnownColors.basicBlack.withValues(alpha: 0.45),
        shape: BoxShape.circle,
      ),
      child: IconButton(
        onPressed: onPressed,
        icon: Icon(icon, color: KnownColors.basicWhite),
        iconSize: 22,
      ),
    );
  }
}
