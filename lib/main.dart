import 'dart:async';
import 'dart:developer' as dev;

import 'package:echo_frame/app.dart';
import 'package:echo_frame/constants/constants.dart';
import 'package:echo_frame/database/database.dart';
import 'package:echo_frame/services/config_service.dart';
import 'package:echo_frame/utilities/utilities.dart' show Prefs;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:media_kit/media_kit.dart';
import 'package:window_manager/window_manager.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  MediaKit.ensureInitialized();

  await windowManager.ensureInitialized();
  await Prefs.init();

  final root = Prefs.libraryRootPath;
  if (root != null) {
    await EchoDatabase.open(root);
    await ConfigService.seedPrefsIfNeeded(root);
  }

  final savedW = Prefs.windowWidth;
  final savedH = Prefs.windowHeight;
  final savedX = Prefs.windowX;
  final savedY = Prefs.windowY;
  final hasSavedGeometry = savedW != null && savedH != null;

  final windowOptions = WindowOptions(
    size: hasSavedGeometry
        ? Size(savedW, savedH)
        : const Size(Sizes.kInitWindowWidth, Sizes.kInitWindowHeight),
    minimumSize: Sizes.kMinWindowSize,
    center: !hasSavedGeometry,
    titleBarStyle: TitleBarStyle.hidden,
    title: 'Echo Frame',
  );

  await windowManager.waitUntilReadyToShow(windowOptions, () async {
    if (hasSavedGeometry && savedX != null && savedY != null) {
      await windowManager.setPosition(Offset(savedX, savedY));
    }
    await windowManager.show();
    await windowManager.focus();
  });

  windowManager.addListener(_EchoWindowListener());

  runApp(const ProviderScope(child: EchoFrameApp()));
}

class _EchoWindowListener extends WindowListener {
  Timer? _debounce;

  void _scheduleWrite() {
    _debounce?.cancel();
    _debounce = Timer(Durations.long2, _persist);
  }

  Future<void> _persist() async {
    try {
      final size = await windowManager.getSize();
      final pos = await windowManager.getPosition();
      Prefs.windowWidth = size.width;
      Prefs.windowHeight = size.height;
      Prefs.windowX = pos.dx;
      Prefs.windowY = pos.dy;
    } catch (e, st) {
      dev.log('Failed to persist window geometry: $e',
          stackTrace: st, name: 'EchoWindowListener');
    }
  }

  @override
  void onWindowResize() => _scheduleWrite();

  @override
  void onWindowMove() => _scheduleWrite();
}
