import 'dart:convert';
import 'dart:io';

import 'package:echo_frame/models/timeline/timeline_models.dart';
import 'package:echo_frame/services/library_service.dart';
import 'package:echo_frame/services/metadata_service.dart';
import 'package:flutter/foundation.dart';

class IndexService {
  static const _fileName = '.echo_index.json';

  Future<MonthIndex> getOrBuild(MonthFolder folder) async {
    final file = File('${folder.path}/$_fileName');
    final dirMtime = Directory(folder.path).statSync().modified;

    if (file.existsSync()) {
      try {
        final index = MonthIndex.fromJson(
          jsonDecode(file.readAsStringSync()) as Map<String, dynamic>,
        );
        if (index.generatedAt.isAfter(dirMtime)) return index;
      } catch (_) {}
    }

    return _build(folder);
  }

  Future<MonthIndex> _build(MonthFolder folder) async {
    final file = File('${folder.path}/$_fileName');
    final files = Directory(folder.path)
        .listSync()
        .whereType<File>()
        .where((f) => LibraryService.isMedia(f.path))
        .map((f) => f.path)
        .toList();

    final metas = await MetadataService.readAll(files);

    final items = <Map<String, dynamic>>[];
    for (int i = 0; i < files.length; i++) {
      final m = metas[i];
      debugPrint('[index] ${files[i].split('/').last} → '
          'w=${m?.width} h=${m?.height} '
          'capturedAt=${m?.capturedAt} '
          'camera=${m?.cameraMake} ${m?.cameraModel}');
      if (m != null) items.add(m.toJson());
    }

    final index = MonthIndex(
      version: 1,
      generatedAt: DateTime.now().toUtc(),
      year: folder.year,
      month: folder.month,
      items: items,
    );

    file.writeAsStringSync(jsonEncode(index.toJson()));

    return index;
  }
}
