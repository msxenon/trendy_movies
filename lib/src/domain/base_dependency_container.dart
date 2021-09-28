import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:trendy_movies/src/domain/providers/logger.dart';
import 'package:trendy_movies/src/domain/repo/database.dart';
import 'package:trendy_movies/src/domain/services/i_auth_service.dart';

abstract class BaseDependencyInjector {
  InstanceBuilderCallback<DatabaseService> get databaseService;
  InstanceBuilderCallback<AuthRepo> get authService;
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
  AuthRepo get authService => Get.find();
  DatabaseService get database => Get.find();
  Logger get logger => Get.find();
}
