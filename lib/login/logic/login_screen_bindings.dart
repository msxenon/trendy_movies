import 'package:get/get.dart';
import 'package:terndy_movies/home/home_controller.dart';
import 'package:terndy_movies/login/logic/login_controller.dart';
import 'package:terndy_movies/movies/movies_service.dart';

class LoginScreenBindings extends Bindings {
  @override
  void dependencies() {
    Get.put(LoginController());
  }
}

class HomeScreenBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => HomeProvider());
    Get.put(HomeController(
        homeRepository: HomeRepository(provider: Get.find<HomeProvider>())));
  }
}
