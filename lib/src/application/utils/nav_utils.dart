import 'package:get/get.dart';
import 'package:trendy_movies/src/application/utils/app_routes.dart';
import 'package:trendy_movies/src/domain/base_dependency_container.dart';

void loadFromMainRoute() {
  if (Get.context != null) {
    Get.offAllNamed<void>(
      AppRoutes.mainRoute,
    );
  }
}

void continueAsLoggedIn() {
  if (Get.context != null) {
    if (!di.database.dbInitialized.value) {
      return loadFromMainRoute();
    }
    Get.offAllNamed<void>(AppRoutes.home);
  }
}
