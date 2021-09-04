import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:terndy_movies/presentation/login/logic/login_controller.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<LoginController>(
        builder: (controller) {
          return Center(
            child: ListView(
              shrinkWrap: true,
              children: [
                if (controller.viewState.value.isRegister)
                  TextField(
                    controller: controller.displayNameController,
                    decoration: InputDecoration(
                      hintText: 'Display name',
                      errorText: controller.validateDisplayName(),
                    ),
                  ),
                TextField(
                  controller: controller.emailController,
                  decoration: InputDecoration(
                    hintText: 'Email',
                    errorText: controller.validateEmail(),
                  ),
                ),
                TextField(
                  controller: controller.passwordController,
                  obscureText: true,
                  decoration: InputDecoration(
                    hintText: 'Password',
                    errorText: controller.validatePassword(),
                  ),
                ),
                ElevatedButton(
                    onPressed: controller.submit,
                    child: controller.viewState.value.isLogin
                        ? const Text('Login')
                        : const Text('Register')),
                ElevatedButton(
                    onPressed: controller.toggleLogin,
                    child: controller.viewState.value.isLogin
                        ? const Text('is not registered?')
                        : const Text('is already registered?'))
              ],
            ),
          );
        },
      ),
    );
  }
}
