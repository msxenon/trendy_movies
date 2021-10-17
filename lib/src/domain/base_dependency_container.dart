import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:trendy_movies/src/application/services/database/database_service_impl.dart';
import 'package:trendy_movies/src/domain/providers/logger.dart';
import 'package:trendy_movies/src/domain/services/base_database_service.dart';
import 'package:trendy_movies/src/domain/services/i_auth_service.dart';

abstract class BaseDependencyInjector {
  InstanceBuilderCallback<DatabaseService> get databaseService;
  InstanceBuilderCallback<AuthRepo> get authService;
  LoggerService get logger;
  @required
  @mustCallSuper
  Future<void> init() async {
    await setupMainServices();

    return;
  }

  @mustCallSuper
  Future<void> setupMainServices() async {
    Get
      ..put<LoggerService>(logger)
      ..lazyPut<DatabaseService>(databaseService)
      ..put(authService());
  }
}

BaseToolBox get di => BaseToolBox();

class BaseToolBox {
  AuthRepo get authService => Get.find();
  DatabaseServiceImpl get database =>
      Get.find<DatabaseService>() as DatabaseServiceImpl;
  LoggerService get logger => Get.find();
}
