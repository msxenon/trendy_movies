import 'package:get/get.dart';
import 'package:terndy_movies/login/logic/login_controller.dart';

class LoginScreenBindings extends Bindings {
  @override
  void dependencies() {
    Get.put(LoginController());
  }
}
