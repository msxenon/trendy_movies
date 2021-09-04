import 'package:firebase_core/firebase_core.dart';
import 'package:get/get.dart';
import 'package:terndy_movies/database/database_service_impl.dart';
import 'package:terndy_movies/domain/auth/i_auth_service.dart';
import 'package:terndy_movies/domain/base_dependency_container.dart';
import 'package:terndy_movies/domain/database.dart';
import 'package:terndy_movies/infrastructure/auth/firebase_auth_service.dart';

class DependenciesContainer extends BaseDependencyInjector {
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
}
