import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';
import 'package:terndy_movies/application/utils/app_routes.dart';
import 'package:terndy_movies/application/utils/middlewares/splash_middleware.dart';
import 'package:terndy_movies/dependencies_container.dart';
import 'package:terndy_movies/domain/base_dependency_container.dart';
import 'package:terndy_movies/presentation/home/home_screen.dart';
import 'package:terndy_movies/presentation/login/logic/login_screen_bindings.dart';
import 'package:terndy_movies/presentation/login/ui/login_screen.dart';
import 'package:terndy_movies/presentation/splash/splash_screen.dart';
import 'package:terndy_movies/presentation/user_profile/logic/user_profile_bindings.dart';
import 'package:terndy_movies/presentation/user_profile/ui/user_profile_screen.dart';

void main() {
  _startUp();
}

Future<void> _startUp() async {
  await DependenciesContainer().init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget with BaseToolBox {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      onGenerateTitle: (_) => _generateTitle(),
      logWriterCallback: logger.logWriter,
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate
      ],
      supportedLocales: const [
        Locale('en', 'US'),
      ],
      getPages: [
        GetPage<void>(
          name: AppRoutes.mainRoute,
          page: () => const SplashScreen(),
          middlewares: [
            SplashMiddleware(),
          ],
        ),
        GetPage<void>(
          name: AppRoutes.sign,
          page: () => const LoginScreen(),
          bindings: [
            LoginScreenBindings(),
          ],
        ),
        GetPage<void>(
          name: AppRoutes.home,
          page: () => const HomeScreen(),
          bindings: [
            HomeScreenBindings(),
          ],
        ),
        GetPage<void>(
          name: AppRoutes.userProfile,
          page: () => const UserProfileScreen(),
          bindings: [
            UserProfileBindings(),
          ],
        ),
      ],
      enableLog: true,
    );
  }

  String _generateTitle() {
    return 'Trendy Movies: ${_routeTitle()}';
  }

  String _routeTitle() {
    final currentRoute = Get.currentRoute;
    switch (currentRoute) {
      case AppRoutes.home:
        return 'Home';
      case '':
      case AppRoutes.mainRoute:
        return 'Loading';
      case AppRoutes.sign:
        return 'Sign';
      default:
        return 'Unknown';
    }
  }
}
