import 'package:get/get.dart';
import 'package:terndy_movies/application/utils/app_routes.dart';

class NavUtils {
  static void loadFromMainRoute() {
    if (Get.context != null) {
      Get.offAllNamed<void>(AppRoutes.mainRoute);
    }
  }

  static void continueAsLoggedIn() {
    if (Get.context != null) {
      Get.offAllNamed(AppRoutes.home);
    }
  }
}
