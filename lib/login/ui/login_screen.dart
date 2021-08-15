import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:terndy_movies/login/logic/login_controller.dart';

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<LoginController>(
        builder: (controller) {
          return Center(
            child: ListView(
              shrinkWrap: true,
              children: [
                TextField(
                  controller: controller.emailController,
                ),
                TextField(
                  controller: controller.passwordController,
                ),
                ElevatedButton(
                    onPressed: controller.register, child: Text('login'))
              ],
            ),
          );
        },
      ),
    );
  }
}
