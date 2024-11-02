import 'package:flutter/widgets.dart';

final GlobalKey<NavigatorState> globalKey = GlobalKey();

BuildContext get globalContext => globalKey.currentContext!;