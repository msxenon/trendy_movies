import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:get/get.dart';
import 'package:terndy_movies/application/localisation/keys.dart';
import 'package:terndy_movies/application/utils/app_routes.dart';
import 'package:terndy_movies/application/utils/middlewares/splash_middleware.dart';
import 'package:terndy_movies/dependencies_container.dart';
import 'package:terndy_movies/domain/base_dependency_container.dart';
import 'package:terndy_movies/presentation/home/ui/home_screen.dart';
import 'package:terndy_movies/presentation/login/logic/login_screen_bindings.dart';
import 'package:terndy_movies/presentation/login/ui/login_screen.dart';
import 'package:terndy_movies/presentation/splash/splash_screen.dart';
import 'package:terndy_movies/presentation/user_profile/logic/user_profile_bindings.dart';
import 'package:terndy_movies/presentation/user_profile/ui/user_profile_screen.dart';

void main() {
  _startUp();
}

Future<void> _startUp() async {
  var delegate = await LocalizationDelegate.create(
      fallbackLocale: 'en_US', supportedLocales: ['en_US']);
  await DependenciesContainer().init();
  runApp(LocalizedApp(delegate, const MyApp()));
}

class MyApp extends StatelessWidget with BaseToolBox {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    var localizationDelegate = LocalizedApp.of(context).delegate;

    return LocalizationProvider(
      state: LocalizationProvider.of(context).state,
      child: GetMaterialApp(
        onGenerateTitle: (_) => _generateTitle(),
        logWriterCallback: logger.logWriter,
        localizationsDelegates: [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          localizationDelegate
        ],
        theme: ThemeData.light(),
        darkTheme: ThemeData.dark(),
        themeMode: Get.isDarkMode ? ThemeMode.dark : ThemeMode.light,
        supportedLocales: localizationDelegate.supportedLocales,
        locale: localizationDelegate.currentLocale,
        builder: (context, child) {
          return AnnotatedRegion<SystemUiOverlayStyle>(
            child: child ?? const SizedBox.shrink(),
            value: !Get.isDarkMode
                ? SystemUiOverlayStyle.dark
                : SystemUiOverlayStyle.light
                    .copyWith(systemNavigationBarColor: Colors.white),
          );
        },
        initialRoute: AppRoutes.mainRoute,
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
            transition: Transition.noTransition,
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
      ),
    );
  }

  String _generateTitle() {
    return '${Keys.App_Name.trans}: ${_routeTitle()}';
  }

  String _routeTitle() {
    final currentRoute = Get.currentRoute;
    switch (currentRoute) {
      case AppRoutes.home:
        return Keys.Route_Titles_Home.trans;
      case '':
      case AppRoutes.mainRoute:
        return Keys.Route_Titles_Main_Route.trans;
      case AppRoutes.sign:
        return Keys.Route_Titles_Sign.trans;
      default:
        return Keys.Route_Titles_Unknown.trans;
    }
  }
}
