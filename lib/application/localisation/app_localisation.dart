import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:get/get.dart';

class AppTranslation extends GetxService {
  static Map<String, Map<String, String>> translationsKeys =
      <String, Map<String, String>>{
    'en': en,
  };
  static late Map<String, String> en;

  Future<AppTranslation> init() async {
    final _en = await _getJsonFromAssets('assets/strings/en.json');
    en = Map<String, String>.from(_en);
    return this;
  }

  dynamic _getJsonFromAssets(String path) async {
    final string = await rootBundle.loadString(path);
    return json.decode(string);
  }
}
