import 'package:echo_frame/app.dart';
import 'package:echo_frame/services/startup_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await StartupService.initialize();
  await StartupService.initWindowManager();
  runApp(const ProviderScope(child: EchoFrameApp()));
}
