import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';

class DatabaseImpl extends GetxService {
  Box? _anonymousBox;
  Box get anonymousBox => _anonymousBox!;

  Future<void> initApp() async {
    await Hive.initFlutter();
    _anonymousBox = await Hive.openBox('anonymous_box');
    return;
  }
}
