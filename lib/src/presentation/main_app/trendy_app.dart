import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:get/get.dart';
import 'package:trendy_movies/src/application/localisation/keys.dart';
import 'package:trendy_movies/src/application/utils/app_routes.dart';
import 'package:trendy_movies/src/application/utils/middlewares/splash_middleware.dart';
import 'package:trendy_movies/src/domain/base_dependency_container.dart';
import 'package:trendy_movies/src/presentation/home/logic/home_bindings.dart';
import 'package:trendy_movies/src/presentation/home/ui/home_screen.dart';
import 'package:trendy_movies/src/presentation/login/logic/login_screen_bindings.dart';
import 'package:trendy_movies/src/presentation/login/ui/login_screen.dart';
import 'package:trendy_movies/src/presentation/splash/splash_screen.dart';
import 'package:trendy_movies/src/presentation/user_profile/logic/user_profile_bindings.dart';
import 'package:trendy_movies/src/presentation/user_profile/ui/user_profile_screen.dart';

class TrendyApp extends StatelessWidget with BaseToolBox {
  TrendyApp({Key? key}) : super(key: key);
  final _pages = [
    GetPage<void>(
      title: Keys.Route_Titles_Main_Route.trans,
      name: AppRoutes.mainRoute,
      page: () => const SplashScreen(),
      middlewares: [
        SplashMiddleware(),
      ],
    ),
    GetPage<void>(
      title: Keys.Actions_Sign_In.trans,
      name: AppRoutes.sign,
      page: () => LoginScreen(),
      bindings: [
        LoginScreenBindings(),
      ],
    ),
    GetPage<void>(
      title: Keys.Route_Titles_Home.trans,
      name: AppRoutes.home,
      page: () => HomeScreen(),
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
        title: Keys.App_Name.trans,
        logWriterCallback: logger.logWriter,
        localizationsDelegates: [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          localizationDelegate,
        ],
        builder: (_, widget) {
          final invertedBrightness =
              Get.isDarkMode ? Brightness.light : Brightness.dark;
          SystemChrome.setSystemUIOverlayStyle(
            SystemUiOverlayStyle(
              systemNavigationBarColor: Colors.transparent,
              statusBarColor: Colors.transparent,
              statusBarIconBrightness: invertedBrightness,
              systemNavigationBarIconBrightness: invertedBrightness,
            ),
          );

          return widget ?? const SizedBox.shrink();
        },
        theme: ThemeData.light(),
        darkTheme: ThemeData.dark(),
        themeMode: Get.isDarkMode ? ThemeMode.dark : ThemeMode.light,
        supportedLocales: localizationDelegate.supportedLocales,
        locale: localizationDelegate.currentLocale,
        initialRoute: AppRoutes.mainRoute,
        getPages: _pages,
        enableLog: true,
        defaultGlobalState: true,
        opaqueRoute: false,
        routingCallback: kIsWeb
            ? (r) {
                final canSetTitle =
                    r?.route?.isActive == true && r?.route?.isCurrent == true;
                final routeName = r?.current;
                if (canSetTitle && routeName != null) {
                  String? title;
                  switch (routeName) {
                    case AppRoutes.home:
                      title = Keys.Route_Titles_Home.trans;
                      break;
                    case AppRoutes.mainRoute:
                      title = Keys.Route_Titles_Main_Route.trans;
                      break;
                    case AppRoutes.sign:
                      title = Keys.Actions_Sign_In.trans;
                      break;
                    case AppRoutes.userProfile:
                      title = Keys.Route_Titles_Profile.trans;
                      break;
                  }
                  if (title != null) {
                    setPageTitle(title);
                  }
                }
              }
            : null,
      ),
    );
  }
}

// This function is used to update the page title on web
void setPageTitle(String title) {
  SystemChrome.setApplicationSwitcherDescription(ApplicationSwitcherDescription(
    label: title,
    primaryColor:
        Theme.of(Get.context!).primaryColor.value, // This line is required
  ));
}
