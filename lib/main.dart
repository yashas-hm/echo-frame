import 'package:echo_frame/app.dart';
import 'package:echo_frame/constants/constants.dart';
import 'package:echo_frame/database/database.dart';
import 'package:echo_frame/utilities/utilities.dart' show Prefs;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:window_manager/window_manager.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await windowManager.ensureInitialized();

  await Prefs.init();

  final root = Prefs.libraryRootPath;
  if (root != null) {
    await EchoDatabase.open(root);
  }

  const windowOptions = WindowOptions(
    size: Size(Sizes.kInitWindowWidth, Sizes.kInitWindowHeight),
    minimumSize: Sizes.kMinWindowSize,
    center: true,
    title: 'Echo Frame',
  );

  await windowManager.waitUntilReadyToShow(windowOptions, () async {
    await windowManager.show();
    await windowManager.focus();
  });

  runApp(const ProviderScope(child: EchoFrameApp()));
}
