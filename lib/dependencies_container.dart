import 'package:firebase_core/firebase_core.dart';
import 'package:get/get.dart';

import 'database/databaseimpl.dart';
import 'login/logic/auth_service.dart';

class DependenciesContainer {
  Future<void> onAppLaunch() async {
    await Get.putAsync<DatabaseImpl>(() async {
      final x = DatabaseImpl();
      await x.initApp();
      return x;
    });
    await Firebase.initializeApp();

    Get.put(AuthService());
    return;
  }
}

class BaseToolBox {
  AuthService get authService => Get.find();
  DatabaseImpl get database => Get.find();
}
