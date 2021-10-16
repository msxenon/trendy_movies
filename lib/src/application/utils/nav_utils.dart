import 'package:get/get.dart';
import 'package:trendy_movies/src/application/utils/app_routes.dart';

void loadFromMainRoute() {
  if (Get.context != null) {
    Get.offAllNamed<void>(
      AppRoutes.mainRoute,
    );
  }
}

void continueAsLoggedIn() {
  if (Get.context != null) {
    Get.offAllNamed<void>(AppRoutes.home);
  }
}