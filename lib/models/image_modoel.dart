import 'dart:ui';

import 'package:echo_frame/models/exif_data_model.dart';

class EchoImage{
  EchoImage({required this.path});
  
  String path;
  Image? image;
  EchoExifData? exif;
}