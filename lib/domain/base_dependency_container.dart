import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:terndy_movies/domain/auth/i_auth_service.dart';
import 'package:terndy_movies/domain/database.dart';
import 'package:terndy_movies/domain/logger.dart';

abstract class BaseDependencyInjector {
  InstanceBuilderCallback<DatabaseService> get databaseService;
  InstanceBuilderCallback<AuthService> get authService;
  Logger get logger;
  @required
  @mustCallSuper
  Future<void> init() async {
    await setupMainServices();
    return;
  }

  @mustCallSuper
  Future<void> setupMainServices() async {
    Get.put<Logger>(logger);
    await Get.putAsync<DatabaseService>(() async {
      final x = databaseService();
      await x.initDb();
      return x;
    });
    Get.put(authService());
  }
}

class BaseToolBox {
  AuthService get authService => Get.find();
  DatabaseService get database => Get.find();
  Logger get logger => Get.find();
}
