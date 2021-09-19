import 'package:get/get.dart';
import 'package:trendy_movies/presentation/user_profile/logic/user_profile_controller.dart';

class UserProfileBindings extends Bindings {
  @override
  void dependencies() {
    Get.put(UserProfileController());
  }
}
