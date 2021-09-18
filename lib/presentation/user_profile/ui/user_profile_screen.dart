import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:terndy_movies/application/localisation/keys.dart';
import 'package:terndy_movies/presentation/user_profile/logic/user_profile_controller.dart';
import 'package:terndy_movies/presentation/user_profile/ui/user_avatar.dart';

class UserProfileScreen extends GetWidget<UserProfileController> {
  const UserProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(Keys.Route_Titles_Profile.trans),
        centerTitle: true,
        actions: [
          TextButton(
            onPressed: controller.saveChanges,
            child: Text(
              Keys.Actions_Done.trans,
              style: const TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
      body: GetBuilder<UserProfileController>(
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
                  onChanged: controller.toggleTheme,
                  title: Text(Keys.App_Is_Dark_Theme.trans),
                ),
                ListTile(
                  title: ElevatedButton(
                    onPressed: controller.authService.signOut,
                    child: Text(Keys.User_Sign_Out.trans),
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
