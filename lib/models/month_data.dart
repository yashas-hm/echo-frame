import 'package:echo_frame/models/media/media.dart' show MediaItem;

class MonthData {
  final int year;
  final int month;
  final List<MediaItem> items;

  const MonthData({
    required this.year,
    required this.month,
    required this.items,
  });
}
