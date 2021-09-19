import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:trendy_movies/application/localisation/keys.dart';
import 'package:trendy_movies/presentation/user_profile/logic/user_profile_controller.dart';
import 'package:trendy_movies/presentation/user_profile/ui/user_avatar.dart';

class UserProfileBody extends GetView<UserProfileController> {
  const UserProfileBody({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<UserProfileController>(
      builder: (controller) {
        return Center(
          child: ListView(
            shrinkWrap: true,
            children: [
              Container(
                alignment: Alignment.center,
                child: UserAvatar(
                  size: Get.width / 2,
                ),
              ),
              ListTile(
                title: TextField(
                  enabled: false,
                  controller: TextEditingController(text: 'e@e.com'),
                  decoration: InputDecoration(
                    hintText: Keys.User_Email.trans,
                  ),
                ),
              ),
              ListTile(
                title: TextField(
                  controller: controller.displayNameController,
                  decoration: InputDecoration(
                    hintText: Keys.User_Display_Name.trans,
                    errorText: controller.validateDisplayName(),
                  ),
                ),
              ),
              SwitchListTile.adaptive(
                value: controller.isDarkTheme,
                onChanged: (v) => controller.toggleTheme(isDarkMode: v),
                title: Text(Keys.App_Is_Dark_Theme.trans),
              ),
              ListTile(
                title: ElevatedButton(
                  onPressed: controller.authService.signOut,
                  child: Text(Keys.User_Sign_Out.trans),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
