import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:trendy_movies/src/application/services/database/database_service_impl.dart';
import 'package:trendy_movies/src/application/utils/platform_custom_injector/custom_injector_io.dart'
    if (dart.library.html) 'package:trendy_movies/src/application/utils/platform_custom_injector/custom_injector_js.dart';
import 'package:trendy_movies/src/data/providers/logger_dev_impl.dart';
import 'package:trendy_movies/src/data/providers/logger_prod_impl.dart';
import 'package:trendy_movies/src/domain/base_dependency_container.dart';
import 'package:trendy_movies/src/domain/providers/logger.dart';
import 'package:trendy_movies/src/domain/services/base_database_service.dart';
import 'package:trendy_movies/src/domain/services/i_auth_service.dart';
import 'package:trendy_movies/src/infrastructure/auth/firebase_auth_service.dart';

class DependenciesContainer extends BaseDependencyInjector {
  @override
  Future<void> init() async {
    WidgetsFlutterBinding.ensureInitialized();
    platformCustomizedInjector();
    await super.init();

    return;
  }

  @override
  Future<void> setupMainServices() async {
    await Firebase.initializeApp();

    return super.setupMainServices();
  }

  @override
  InstanceBuilderCallback<AuthRepo> get authService =>
      () => FirebaseAuthService();

  @override
  InstanceBuilderCallback<DatabaseService> get databaseService =>
      () => DatabaseServiceImpl();

  @override
  LoggerService get logger => kReleaseMode ? LoggerProdImpl() : LoggerDevImpl();
}
