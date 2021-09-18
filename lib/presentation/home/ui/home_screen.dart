import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:terndy_movies/application/localisation/keys.dart';
import 'package:terndy_movies/application/utils/app_routes.dart';
import 'package:terndy_movies/domain/base_dependency_container.dart';
import 'package:terndy_movies/presentation/home/ui/trendy_movies_page.dart';
import 'package:terndy_movies/presentation/user_profile/ui/user_avatar.dart';

class HomeScreen extends StatelessWidget with BaseToolBox {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          Keys.App_Welcome_User_Name.transArgs(
            {
              'name': authService.signedInUserModel.displayName,
            },
          ),
        ),
        actions: [
          Container(
            alignment: Alignment.center,
            child: InkWell(
              child: const UserAvatar(),
              onTap: () => Get.toNamed(AppRoutes.userProfile),
            ),
          ),
        ],
      ),
      body: const TrendyMoviesPage(),
    );
  }
}
