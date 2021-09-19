import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:terndy_movies/application/logger_dev_impl.dart';
import 'package:terndy_movies/application/logger_prod_impl.dart';
import 'package:terndy_movies/application/utils/platform_custom_injector/custom_injector_io.dart'
    if (dart.library.html) 'package:terndy_movies/application/utils/platform_custom_injector/custom_injector_js.dart';
import 'package:terndy_movies/database/database_service_impl.dart';
import 'package:terndy_movies/domain/auth/i_auth_service.dart';
import 'package:terndy_movies/domain/base_dependency_container.dart';
import 'package:terndy_movies/domain/database.dart';
import 'package:terndy_movies/domain/logger.dart';
import 'package:terndy_movies/infrastructure/auth/firebase_auth_service.dart';

class DependenciesContainer extends BaseDependencyInjector {
  @override
  Future<void> init() async {
    WidgetsFlutterBinding.ensureInitialized();
    await dotenv.load();
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
  InstanceBuilderCallback<AuthService> get authService =>
      () => FirebaseAuthService();

  @override
  InstanceBuilderCallback<DatabaseService> get databaseService =>
      () => DatabaseServiceImpl();

  @override
  Logger get logger => kReleaseMode ? LoggerProdImpl() : LoggerDevImpl();
}
