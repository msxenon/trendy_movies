import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:terndy_movies/application/localisation/keys.dart';
import 'package:terndy_movies/presentation/user_profile/logic/user_profile_controller.dart';
import 'package:terndy_movies/presentation/user_profile/ui/user_profile_body.dart';

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
      body: const UserProfileBody(),
    );
  }
}
