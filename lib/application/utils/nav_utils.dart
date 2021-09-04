import 'package:get/get.dart';

class NavUtils {
  static void loadFromMainRoute() {
    Get.offAndToNamed<void>('/');
  }
}
