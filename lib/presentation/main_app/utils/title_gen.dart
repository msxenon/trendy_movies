import 'package:get/get.dart';
import 'package:trendy_movies/application/localisation/keys.dart';
import 'package:trendy_movies/application/utils/app_routes.dart';

String generateTitle() {
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
