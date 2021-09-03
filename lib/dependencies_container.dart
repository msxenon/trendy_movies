import 'package:firebase_core/firebase_core.dart';
import 'package:get/get.dart';
import 'package:terndy_movies/database/database_service_impl.dart';
import 'package:terndy_movies/domain/auth/i_auth_service.dart';
import 'package:terndy_movies/infrastructure/auth/firebase_auth_service.dart';

class DependenciesContainer {
  Future<void> onAppLaunch() async {
    await Get.putAsync<DatabaseServiceImpl>(() async {
      final x = DatabaseServiceImpl();
      await x.initApp();
      return x;
    });
    await Firebase.initializeApp();

    Get.put(FirebaseAuthService());
    return;
  }
}

class BaseToolBox {
  AuthService get authService => Get.find();
  DatabaseServiceImpl get database => Get.find();
}
