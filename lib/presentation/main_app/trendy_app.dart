import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:get/get.dart';
import 'package:terndy_movies/application/utils/app_routes.dart';
import 'package:terndy_movies/application/utils/middlewares/splash_middleware.dart';
import 'package:terndy_movies/domain/base_dependency_container.dart';
import 'package:terndy_movies/presentation/home/ui/home_screen.dart';
import 'package:terndy_movies/presentation/login/logic/login_screen_bindings.dart';
import 'package:terndy_movies/presentation/login/ui/login_screen.dart';
import 'package:terndy_movies/presentation/main_app/utils/app_annotated_region.dart';
import 'package:terndy_movies/presentation/main_app/utils/title_gen.dart';
import 'package:terndy_movies/presentation/splash/splash_screen.dart';
import 'package:terndy_movies/presentation/user_profile/logic/user_profile_bindings.dart';
import 'package:terndy_movies/presentation/user_profile/ui/user_profile_screen.dart';

class TrendyApp extends StatelessWidget with BaseToolBox {
  TrendyApp({Key? key}) : super(key: key);
  final _pages = [
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
  ];
  @override
  Widget build(BuildContext context) {
    final localizationDelegate = LocalizedApp.of(context).delegate;

    return LocalizationProvider(
      state: LocalizationProvider.of(context).state,
      child: GetMaterialApp(
        onGenerateTitle: (_) => generateTitle(),
        logWriterCallback: logger.logWriter,
        localizationsDelegates: [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          localizationDelegate,
        ],
        theme: ThemeData.light(),
        darkTheme: ThemeData.dark(),
        themeMode: Get.isDarkMode ? ThemeMode.dark : ThemeMode.light,
        supportedLocales: localizationDelegate.supportedLocales,
        locale: localizationDelegate.currentLocale,
        builder: (context, child) {
          return AppAnnotatedRegion(child: child);
        },
        initialRoute: AppRoutes.mainRoute,
        getPages: _pages,
        enableLog: true,
      ),
    );
  }
}
