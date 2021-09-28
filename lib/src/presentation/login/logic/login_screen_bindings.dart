import 'package:get/get.dart';
import 'package:trendy_movies/src/presentation/login/logic/login_controller.dart';

class LoginScreenBindings extends Bindings {
  @override
  void dependencies() {
    Get.put(LoginController());
  }
}
