import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:trendy_movies/src/application/services/database/hive_database_service.dart';
import 'package:trendy_movies/src/domain/providers/logger.dart';
import 'package:trendy_movies/src/domain/services/base_database_service.dart';
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
    Get
      ..put<Logger>(logger)
      ..lazyPut<DatabaseService>(databaseService)
      ..put(authService());
  }
}

BaseToolBox get di => BaseToolBox();

class BaseToolBox {
  AuthRepo get authService => Get.find();
  AppDatabaseService get database => Get.find();
  Logger get logger => Get.find();
}
