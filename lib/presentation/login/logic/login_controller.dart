import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:terndy_movies/dependencies_container.dart';

enum LoginViewState { login, register, reset }

class LoginController extends GetxController with BaseToolBox {
  final Rx<LoginViewState> viewState = LoginViewState.login.obs;
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final RxBool _validate = false.obs;
  Future<void> register() {
    _validate(true);
    update();
    if (!validateLogin()) {
      return Future.value();
    }
    return authService.registerWithEmail(
        email: emailController.text, password: passwordController.text);
  }

  Future<void> login() {
    _validate(true);
    update();
    if (!validateLogin()) {
      return Future.value();
    }
    return authService.signInWithEmail(
        email: emailController.text, password: passwordController.text);
  }

  bool validateLogin() {
    return validateEmail() == null && validatePassword() == null;
  }

  String? validatePassword() {
    if (!_validate.value) {
      return null;
    }
    if (passwordController.text.isEmpty) {
      return 'Password should not be empty';
    }
    return null;
  }

  String? validateEmail() {
    if (!_validate.value) {
      return null;
    }
    if (!emailController.text.isEmail) {
      return 'Wrong email pattern';
    }
    return null;
  }
}
