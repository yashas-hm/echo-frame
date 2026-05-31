import 'dart:io';

import 'package:echo_frame/database/daos/media_dao.dart';
import 'package:echo_frame/database/database.dart';
import 'package:echo_frame/models/media_item.dart';
import 'package:echo_frame/views/photo_view/photo_detail_panel.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class PhotoViewScreen extends StatefulWidget {
  const PhotoViewScreen({super.key, required this.mediaId});

  final int mediaId;

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

    return Scaffold(
      backgroundColor: Colors.black,
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
                          children: const [
                            Icon(Icons.broken_image_outlined,
                                size: 64, color: Colors.white38),
                            SizedBox(height: 8),
                            Text('File not available',
                                style: TextStyle(color: Colors.white54)),
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
    );
  }
}
