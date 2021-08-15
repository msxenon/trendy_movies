import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:terndy_movies/dependencies_container.dart';

enum LoginViewState { login, register, reset }

class LoginController extends GetxController with BaseToolBox {
  final Rx<LoginViewState> viewState = LoginViewState.login.obs;
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  Future<void> register() {
    return _register(emailController.text, passwordController.text);
  }

  Future<void> _register(String email, String password) async {
    if (!email.isEmail) {}

    if (password.isEmpty) {}

    return authService.register(email, password);
  }
}
