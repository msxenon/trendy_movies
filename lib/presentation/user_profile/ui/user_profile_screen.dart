import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:terndy_movies/presentation/user_profile/logic/user_profile_controller.dart';
import 'package:terndy_movies/presentation/user_profile/ui/user_avatar.dart';

class UserProfileScreen extends GetWidget<UserProfileController> {
  const UserProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        centerTitle: true,
        actions: [
          TextButton(
            onPressed: controller.saveChanges,
            child: const Text(
              'Done',
              style: TextStyle(color: Colors.white),
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
                TextField(
                  enabled: false,
                  controller: TextEditingController(text: 'e@e.com'),
                  decoration: const InputDecoration(
                    hintText: 'Email',
                  ),
                ),
                TextField(
                  controller: controller.displayNameController,
                  decoration: InputDecoration(
                    hintText: 'Display name',
                    errorText: controller.validateDisplayName(),
                  ),
                ),
                ElevatedButton(
                  onPressed: controller.authService.signOut,
                  child: const Text('Sign out'),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
