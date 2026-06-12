import 'dart:io';

import 'package:echo_frame/database/daos/media_dao.dart';
import 'package:echo_frame/database/database.dart';
import 'package:echo_frame/models/media_item.dart';
import 'package:echo_frame/views/photo_view/photo_detail_panel.dart';
import 'package:echo_frame/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';

class PhotoViewScreen extends StatefulWidget {
  const PhotoViewScreen({super.key, required this.mediaId});

  final int mediaId;

  static const String path = '/photo';
  static String route(int id) => '$path/$id';
  static GoRoute get routeDef => GoRoute(
        path: '$path/:id',
        builder: (_, state) => PhotoViewScreen(
          mediaId: int.parse(state.pathParameters['id']!),
        ),
      );

  @override
  State<PhotoViewScreen> createState() => _PhotoViewScreenState();
}

class _PhotoViewScreenState extends State<PhotoViewScreen> {
  List<MediaItem> _siblings = [];
  late PageController _pageController;
  int _currentIndex = 0;
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    _loadData();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  Future<void> _loadData() async {
    if (!EchoDatabase.isOpen) {
      if (mounted) setState(() => _loading = false);
      return;
    }
    final dao = MediaDao(EchoDatabase.instance);
    final record = await dao.getById(widget.mediaId);

    if (record == null || !mounted) {
      setState(() => _loading = false);
      return;
    }

    final siblings = await dao.queryByMonth(
      record.capturedYear ?? record.capturedAt!.year,
      record.capturedMonth ?? record.capturedAt!.month,
    );

    final index = siblings.indexWhere((r) => r.id == widget.mediaId);

    if (mounted) {
      final clampedIndex = index.clamp(0, siblings.length - 1);
      _pageController = PageController(initialPage: clampedIndex);
      setState(() {
        _siblings = siblings.map(MediaItem.fromRecord).toList();
        _currentIndex = clampedIndex;
        _loading = false;
      });
    }
  }

  void _goToPage(int index) {
    if (index < 0 || index >= _siblings.length) return;
    _pageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 200),
      curve: Curves.easeInOut,
    );
  }

  KeyEventResult _handleKey(FocusNode _, KeyEvent event) {
    if (event is! KeyDownEvent) return KeyEventResult.ignored;
    switch (event.logicalKey) {
      case LogicalKeyboardKey.arrowRight:
        _goToPage(_currentIndex + 1);
        return KeyEventResult.handled;
      case LogicalKeyboardKey.arrowLeft:
        _goToPage(_currentIndex - 1);
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

    if (_siblings.isEmpty) {
      return Scaffold(
        body: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text('Photo not found'),
              const SizedBox(height: 16),
              FilledButton(
                onPressed: context.pop,
                child: const Text('Go back'),
              ),
            ],
          ),
        ),
      );
    }

    final current = _siblings[_currentIndex];

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
                    PageView.builder(
                      controller: _pageController,
                      onPageChanged: (i) => setState(() => _currentIndex = i),
                      itemCount: _siblings.length,
                      itemBuilder: (_, i) => InteractiveViewer(
                        child: Center(
                          child: Image.file(
                            File(_siblings[i].filePath),
                            fit: BoxFit.contain,
                            errorBuilder: (_, __, ___) => Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(Icons.broken_image_outlined,
                                    size: 64, color: KnownColors.basicWhite.withValues(alpha: 0.38)),
                                const SizedBox(height: 8),
                                Text('File not available',
                                    style: TextStyle(color: KnownColors.basicWhite.withValues(alpha: 0.54))),
                              ],
                            ),
                          ),
                        ),
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
                  ],
                ),
              ),
              PhotoDetailPanel(item: current),
            ],
          ),
        ));
  }
}
