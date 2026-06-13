import 'dart:async';
import 'dart:developer' as dev;

import 'package:echo_frame/database/daos/media_dao.dart';
import 'package:echo_frame/database/database.dart';
import 'package:echo_frame/models/media_item.dart';
import 'package:echo_frame/theme/theme.dart';
import 'package:echo_frame/utilities/utilities.dart' show ContextExtension;
import 'package:echo_frame/views/gallery/gallery_info_panel.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:media_kit/media_kit.dart';
import 'package:media_kit_video/media_kit_video.dart';

class VideoScreen extends StatefulWidget {
  const VideoScreen({super.key, required this.mediaId});

  final int mediaId;

  static const String path = '/video';

  static String route(int id) => '$path/$id';

  static GoRoute get routeDef => GoRoute(
        path: '$path/:id',
        builder: (_, state) => VideoScreen(
          mediaId: int.parse(state.pathParameters['id']!),
        ),
      );

  @override
  State<VideoScreen> createState() => _VideoScreenState();
}

class _VideoScreenState extends State<VideoScreen> {
  late final Player _player;
  late final VideoController _controller;
  MediaItem? _item;
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _player = Player();
    _controller = VideoController(_player);
    _loadData();
  }

  @override
  void dispose() {
    _player.dispose();
    super.dispose();
  }

  Future<void> _loadData() async {
    if (!EchoDatabase.isOpen) {
      if (mounted) setState(() => _loading = false);
      return;
    }
    try {
      final record =
          await MediaDao(EchoDatabase.instance).getById(widget.mediaId);
      if (!mounted) return;
      if (record != null) {
        final item = MediaItem.fromRecord(record);
        setState(() {
          _item = item;
          _loading = false;
        });
        await _player.open(Media(item.filePath));
      } else {
        setState(() => _loading = false);
      }
    } catch (e, st) {
      dev.log('Failed to load video: $e',
          stackTrace: st, name: 'VideoScreen._loadData');
      if (mounted) setState(() => _loading = false);
    }
  }

  KeyEventResult _handleKey(FocusNode _, KeyEvent event) {
    if (event is! KeyDownEvent) return KeyEventResult.ignored;
    switch (event.logicalKey) {
      case LogicalKeyboardKey.space:
        _player.playOrPause();
        return KeyEventResult.handled;
      case LogicalKeyboardKey.escape:
        context.pop();
        return KeyEventResult.handled;
    }
    return KeyEventResult.ignored;
  }

  @override
  Widget build(BuildContext context) {
    if (_loading) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    final item = _item;
    if (item == null) {
      return Scaffold(
        body: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text('Video not found'),
              const SizedBox(height: 16),
              FilledButton(
                  onPressed: context.pop, child: const Text('Go back')),
            ],
          ),
        ),
      );
    }

    return Focus(
      autofocus: true,
      onKeyEvent: _handleKey,
      child: Scaffold(
        backgroundColor: KnownColors.basicBlack,
        body: Row(
          children: [
            Expanded(
              child: Stack(
                children: [
                  GestureDetector(
                    onTap: _player.playOrPause,
                    child: Video(
                      controller: _controller,
                      controls: NoVideoControls,
                    ),
                  ),
                  Positioned(
                    top: 16,
                    left: 16,
                    child: IconButton.filledTonal(
                      onPressed: context.pop,
                      icon: const Icon(Icons.arrow_back_rounded),
                    ),
                  ),
                  Positioned(
                    left: 0,
                    right: 0,
                    bottom: 0,
                    child: _Controls(player: _player),
                  ),
                ],
              ),
            ),
            GalleryInfoPanel(item: item),
          ],
        ),
      ),
    );
  }
}

class _Controls extends StatefulWidget {
  const _Controls({required this.player});

  final Player player;

  @override
  State<_Controls> createState() => _ControlsState();
}

class _ControlsState extends State<_Controls> {
  late bool _playing;
  late Duration _position;
  late Duration _duration;
  final List<StreamSubscription<dynamic>> _subs = [];

  @override
  void initState() {
    super.initState();
    _playing = widget.player.state.playing;
    _position = widget.player.state.position;
    _duration = widget.player.state.duration;
    _subs.addAll([
      widget.player.stream.playing.listen((v) => setState(() => _playing = v)),
      widget.player.stream.position
          .listen((v) => setState(() => _position = v)),
      widget.player.stream.duration
          .listen((v) => setState(() => _duration = v)),
    ]);
  }

  @override
  void dispose() {
    for (final s in _subs) {
      s.cancel();
    }
    super.dispose();
  }

  String _fmt(Duration d) {
    final m = d.inMinutes.remainder(60).toString().padLeft(2, '0');
    final s = d.inSeconds.remainder(60).toString().padLeft(2, '0');
    return d.inHours > 0 ? '${d.inHours}:$m:$s' : '$m:$s';
  }

  @override
  Widget build(BuildContext context) {
    final progress = _duration.inMilliseconds > 0
        ? (_position.inMilliseconds / _duration.inMilliseconds).clamp(0.0, 1.0)
        : 0.0;

    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.bottomCenter,
          end: Alignment.topCenter,
          colors: [
            KnownColors.basicBlack.withValues(alpha: 0.87),
            KnownColors.transparent,
          ],
        ),
      ),
      padding: const EdgeInsets.fromLTRB(16, 32, 16, 12),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SliderTheme(
            data: SliderThemeData(
              trackHeight: 2,
              thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 6),
              overlayShape: const RoundSliderOverlayShape(overlayRadius: 12),
              activeTrackColor: context.colors.primaryColor,
              inactiveTrackColor: KnownColors.basicWhite.withValues(alpha: 0.4),
              thumbColor: KnownColors.basicWhite,
              overlayColor: KnownColors.basicWhite.withValues(alpha: 0.2),
            ),
            child: Slider(
              value: progress,
              onChanged: (v) => widget.player.seek(
                Duration(milliseconds: (v * _duration.inMilliseconds).round()),
              ),
            ),
          ),
          Row(
            children: [
              IconButton(
                onPressed: widget.player.playOrPause,
                icon: Icon(
                  _playing ? Icons.pause_rounded : Icons.play_arrow_rounded,
                  color: KnownColors.basicWhite,
                ),
              ),
              const SizedBox(width: 4),
              Text(
                '${_fmt(_position)} / ${_fmt(_duration)}',
                style: TextStyle(
                  color: KnownColors.basicWhite.withValues(alpha: 0.87),
                  fontSize: 12,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
