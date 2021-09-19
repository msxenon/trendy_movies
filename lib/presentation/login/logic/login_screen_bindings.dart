import 'package:get/get.dart';
import 'package:trendy_movies/movies/movies_service.dart';
import 'package:trendy_movies/presentation/home/logic/home_controller.dart';
import 'package:trendy_movies/presentation/login/logic/login_controller.dart';

class LoginScreenBindings extends Bindings {
  @override
  void dependencies() {
    Get.put(LoginController());
  }
}

class HomeScreenBindings extends Bindings {
  @override
  void dependencies() {
    Get
      ..lazyPut(
        () => HomeProvider(),
      )
      ..put(
        HomeController(
          homeRepository: HomeRepository(
            provider: Get.find<HomeProvider>(),
          ),
        ),
      );
  }
}
