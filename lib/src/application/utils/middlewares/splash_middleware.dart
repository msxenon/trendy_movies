import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:trendy_movies/src/application/utils/app_routes.dart';
import 'package:trendy_movies/src/domain/base_dependency_container.dart';

class SplashMiddleware extends GetMiddleware with BaseToolBox {
  @override
  RouteSettings? redirect(String? route) {
    if (authService.isLoggedIn) {
      return const RouteSettings(name: AppRoutes.home);
    } else if (route != AppRoutes.sign) {
      return const RouteSettings(name: AppRoutes.sign);
    }
  }
}
