import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:trendy_movies/src/application/localisation/keys.dart';
import 'package:trendy_movies/src/application/utils/app_routes.dart';
import 'package:trendy_movies/src/application/widgets/custom_divider.dart';
import 'package:trendy_movies/src/domain/base_dependency_container.dart';
import 'package:trendy_movies/src/presentation/home/ui/trendy_movies_page.dart';
import 'package:trendy_movies/src/presentation/user_profile/ui/user_avatar.dart';

class HomeScreen extends GetResponsiveWidget with BaseToolBox {
  HomeScreen({Key? key}) : super(key: key);
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
        actions: [
          Container(
            alignment: Alignment.center,
            child: InkWell(
              child: const UserAvatar(),
              onTap: () => Get.toNamed<void>(AppRoutes.userProfile),
            ),
          ),
        ],
      ),
      body: TrendyMoviesPage(),
    );
  }

  @override
  Widget? desktop() {
    return Scaffold(
      body: Row(
        children: [
          Drawer(
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
                          'name':
                              authService.signedInUserModel.value.displayName,
                        },
                      ),
                    ),
                  ),
                ),
                const CustomDivider(),
                ListTile(
                  leading: Icon(Icons.favorite),
                  title: Text('Wishlist'),
                ),
                const CustomDivider(),
                ListTile(
                  leading: Icon(Icons.watch_later),
                  title: Text('Watch Later'),
                ),
                const CustomDivider(),
                ListTile(
                  leading: Icon(Icons.remove_red_eye_rounded),
                  title: Text('Seen'),
                ),
              ],
            ),
          ),
          Expanded(child: TrendyMoviesPage()),
        ],
      ),
    );
  }
}
