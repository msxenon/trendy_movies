import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get_navigation/src/routes/route_middleware.dart';
import 'package:terndy_movies/application/utils/app_routes.dart';
import 'package:terndy_movies/domain/base_dependency_container.dart';

class SplashMiddleware extends GetMiddleware with BaseToolBox {
  @override
  RouteSettings? redirect(String? route) {
    if (authService.isLoggedIn) {
      return const RouteSettings(name: AppRoutes.home);
    } else {
      return const RouteSettings(name: AppRoutes.sign);
    }
  }
}