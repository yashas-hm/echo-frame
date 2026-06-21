import 'dart:async';
import 'dart:developer' as dev;
import 'dart:io';

import 'package:echo_frame/constants/constants.dart'
    show Sizes, SpacerExtraSmall, SpacerSmall;
import 'package:echo_frame/models/media_item.dart';
import 'package:echo_frame/theme/theme.dart';
import 'package:echo_frame/utilities/utilities.dart'
    show ContextExtensions, DurationExtensions;
import 'package:echo_frame/views/gallery/components/action_bubble.dart';
import 'package:flutter/material.dart';
import 'package:media_kit/media_kit.dart';
import 'package:media_kit_video/media_kit_video.dart';

sealed class VideoControlFunctions {
  VideoControlFunctions._();

  static void togglePlayPause(BuildContext context, Player? player) {
    if (player == null) return;
    player.playOrPause();
    ActionBubble.show(
      context,
      icon:
          player.state.playing ? Icons.pause_rounded : Icons.play_arrow_rounded,
    );
  }

  static void toggleMute(BuildContext context, Player? player) {
    if (player == null) return;
    if (player.state.volume <= 0) {
      player.setVolume(100);
      ActionBubble.show(context, icon: Icons.volume_up_rounded);
    } else {
      player.setVolume(0);
      ActionBubble.show(context, icon: Icons.volume_off_rounded);
    }
  }
}

class VideoView extends StatefulWidget {
  const VideoView({
    super.key,
    required this.item,
    required this.onPlayerReady,
  });

  final MediaItem item;
  final void Function(Player?) onPlayerReady;

  @override
  State<VideoView> createState() => _VideoViewState();
}

class _VideoViewState extends State<VideoView> {
  late final Player _player;
  late final VideoController _controller;

  @override
  void initState() {
    super.initState();
    _player = Player();
    _controller = VideoController(_player);
    _openFile(widget.item.filePath);
    widget.onPlayerReady(_player);
  }

  @override
  void didUpdateWidget(VideoView old) {
    super.didUpdateWidget(old);
    if (old.item.filePath != widget.item.filePath) {
      _openFile(widget.item.filePath);
    }
  }

  @override
  void dispose() {
    widget.onPlayerReady(null);
    _player.stop().then((_) => _player.dispose());
    super.dispose();
  }

  Future<void> _openFile(String path) async {
    try {
      await _player.open(Media(path));
    } catch (e, st) {
      dev.log(
        'Failed to open video: $e',
        stackTrace: st,
        name: 'VideoView._openFile',
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        GestureDetector(
          onTap: _player.playOrPause,
          child: Hero(
            flightShuttleBuilder: (_, __, ___, ____, _____) {
              final thumb = widget.item.thumbnailPath;
              return thumb != null
                  ? Image.file(File(thumb), fit: BoxFit.contain)
                  : const ColoredBox(color: Colors.black);
            },
            tag: widget.item.id,
            child: Video(
              controller: _controller,
              controls: NoVideoControls,
              fill: KnownColors.transparent,
            ),
          ),
        ),
        Positioned(
          left: 0,
          right: 0,
          bottom: 0,
          child: _VideoControls(player: _player),
        ),
      ],
    );
  }
}

class _VideoControls extends StatefulWidget {
  const _VideoControls({required this.player});

  final Player player;

  @override
  State<_VideoControls> createState() => _VideoControlsState();
}

class _VideoControlsState extends State<_VideoControls> {
  late bool _playing;
  late bool _isMute;
  late Duration _position;
  late Duration _duration;

  final List<StreamSubscription<dynamic>> _subs = [];

  @override
  void initState() {
    super.initState();
    _playing = widget.player.state.playing;
    _position = widget.player.state.position;
    _duration = widget.player.state.duration;
    _isMute = widget.player.state.volume <= 0;
    _subs.addAll([
      widget.player.stream.playing.listen((v) => setState(() => _playing = v)),
      widget.player.stream.position
          .listen((v) => setState(() => _position = v)),
      widget.player.stream.duration
          .listen((v) => setState(() => _duration = v)),
      widget.player.stream.volume
          .listen((v) => setState(() => _isMute = v <= 0)),
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
      padding: const EdgeInsets.all(Sizes.edgePadding),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        spacing: Sizes.spacingSmall,
        children: [
          SliderTheme(
            data: SliderThemeData(
              trackHeight: 2,
              thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 6),
              overlayShape: const RoundSliderOverlayShape(overlayRadius: 10),
              activeTrackColor: context.colors.primaryColor,
              inactiveTrackColor: context.colors.borderPrimary,
              thumbColor: context.colors.onPrimary,
              overlayColor: context.colors.borderPrimary,
            ),
            child: Slider(
              value: progress,
              onChanged: (v) => widget.player
                  .seek((v * _duration.inMilliseconds).round().milliseconds),
            ),
          ),
          Row(
            children: [
              SpacerExtraSmall(),
              InkWell(
                onTap: () => VideoControlFunctions.togglePlayPause(
                  context,
                  widget.player,
                ),
                mouseCursor: SystemMouseCursors.click,
                customBorder: CircleBorder(),
                child: Icon(
                  _playing ? Icons.pause_rounded : Icons.play_arrow_rounded,
                  color: context.colors.textPrimary,
                  size: Sizes.iconSizeRegular,
                ),
              ),
              SpacerSmall(),
              Text(
                '${_fmt(_position)} / ${_fmt(_duration)}',
                style: TextStyle(
                  color: context.colors.textSecondary,
                  fontSize: 12,
                ),
              ),
              Spacer(),
              InkWell(
                onTap: () => VideoControlFunctions.toggleMute(
                  context,
                  widget.player,
                ),
                mouseCursor: SystemMouseCursors.click,
                customBorder: CircleBorder(),
                child: Icon(
                  _isMute ? Icons.volume_off_rounded : Icons.volume_up_rounded,
                  color: context.colors.textPrimary,
                  size: Sizes.iconSizeSmallRegular,
                ),
              ),
              SpacerExtraSmall(),
            ],
          ),
        ],
      ),
    );
  }
}
