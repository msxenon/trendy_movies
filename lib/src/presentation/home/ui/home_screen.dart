import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:trendy_movies/src/application/localisation/keys.dart';
import 'package:trendy_movies/src/application/models/movie_category.dart';
import 'package:trendy_movies/src/application/widgets/custom_divider.dart';
import 'package:trendy_movies/src/domain/base_dependency_container.dart';
import 'package:trendy_movies/src/presentation/home/logic/home_controller.dart';
import 'package:trendy_movies/src/presentation/home/ui/drawer_tile.dart';
import 'package:trendy_movies/src/presentation/home/ui/trendy_movies_page.dart';
import 'package:trendy_movies/src/presentation/movies_category/movies_category_controller.dart';
import 'package:trendy_movies/src/presentation/user_profile/ui/user_avatar.dart';

class HomeScreen extends GetResponsiveWidget<HomeController> with BaseToolBox {
  HomeScreen({Key? key}) : super(key: key, alwaysUseBuilder: true);

  final wishes = Get.find<MoviesCategoryController>(
    tag: MovieCategory.wishList.toString(),
  );
  final seen = Get.find<MoviesCategoryController>(
    tag: MovieCategory.seen.toString(),
  );

  final later = Get.find<MoviesCategoryController>(
    tag: MovieCategory.watchLater.toString(),
  );

  @override
  Widget? phone() {
    return Scaffold(
      appBar: AppBar(
        title: Obx(
          () => Text(
            Keys.App_Welcome_User_Name.transArgs(
              <String, dynamic>{
                'name': authService.signedInUserModel.value.displayName,
              },
            ),
          ),
        ),
      ),
      drawer: _drawer(),
      body: TrendyMoviesPage(),
    );
  }

  @override
  Widget? desktop() {
    return Scaffold(
      body: Row(
        children: [
          _drawer(),
          Expanded(child: TrendyMoviesPage()),
        ],
      ),
    );
  }

  Widget _drawer() {
    return Drawer(
      child: ListView(
        padding: const EdgeInsets.symmetric(vertical: 20),
        children: [
          const UserAvatar(),
          const SizedBox(
            height: 20,
          ),
          Center(
            child: Obx(
              () => Text(
                Keys.App_Welcome_User_Name.transArgs(
                  <String, dynamic>{
                    'name': authService.signedInUserModel.value.displayName,
                  },
                ),
              ),
            ),
          ),
          const CustomDivider(),
          DrawerTile(
            Keys.Route_Titles_Wish_List.trans,
            MovieCategory.wishList,
          ),
          const CustomDivider(),
          DrawerTile(Keys.Route_Titles_Seen.trans, MovieCategory.seen),
          const CustomDivider(),
          DrawerTile(
            Keys.Route_Titles_Watch_Later.trans,
            MovieCategory.watchLater,
          ),
        ],
      ),
    );
  }
}
