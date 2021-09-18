import 'dart:ui';

import 'package:get/get.dart';

enum Langs { russian, english }

class Languages {
  static const Map<String, Locale> all = {
    'Russian': Locale('ru', 'ru'),
    'English': Locale('en', 'us'),
  };

  static String get currentLanguageName =>
      (Get.locale?.languageCode ?? Get.deviceLocale?.languageCode) ==
              all.values.elementAt(0).languageCode
          ? all.keys.elementAt(0)
          : all.keys.elementAt(1);
}
