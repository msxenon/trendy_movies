import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:terndy_movies/application/utils/nav_utils.dart';
import 'package:terndy_movies/domain/auth/auth_failure.dart';
import 'package:terndy_movies/domain/base_dependency_container.dart';

enum LoginViewState { login, register, reset }

extension LoginViewStateExts on LoginViewState {
  bool get isRegister => this == LoginViewState.register;
  bool get isLogin => this == LoginViewState.login;
  bool get isResetPassword => this == LoginViewState.reset;
}

class LoginController extends GetxController with BaseToolBox {
  final Rx<LoginViewState> viewState = LoginViewState.login.obs;
  final TextEditingController emailController =
      TextEditingController(text: 'modi@modi-domain.com');
  final TextEditingController displayNameController = TextEditingController();
  final TextEditingController passwordController =
      TextEditingController(text: '12345678');
  Future<Either<AuthFailure, void>> register() {
    update();
    if (!_validateRegister()) {
      return Future.value();
    }
    return authService.registerWithEmail(
      email: emailController.text,
      password: passwordController.text,
      displayName: displayNameController.text,
    );
  }

  Future<Either<AuthFailure, void>> login() {
    update();
    if (!_validateLogin()) {
      return Future.value();
    }
    return authService.signInWithEmail(
        email: emailController.text, password: passwordController.text);
  }

  bool _validateLogin() {
    return validateEmail() == null && validatePassword() == null;
  }

  bool _validateRegister() {
    return validateEmail() == null &&
        validatePassword() == null &&
        validateDisplayName() == null;
  }

  String? validatePassword() {
    if (passwordController.text.isEmpty) {
      return 'Password should not be empty';
    }
    return null;
  }

  String? validateEmail() {
    if (!emailController.text.isEmail) {
      return 'Wrong email pattern';
    }
    return null;
  }

  String? validateDisplayName() {
    if (displayNameController.text.isEmpty ||
        !displayNameController.text.isAlphabetOnly) {
      return 'Wrong email pattern';
    }
    return null;
  }

  void toggleLogin() {
    if (viewState.value.isLogin) {
      viewState(LoginViewState.register);
    } else {
      viewState(LoginViewState.login);
    }
    update();
  }

  Future<void> submit() async {
    Either<AuthFailure, void> result;
    if (viewState.value.isLogin) {
      result = await login();
    } else {
      result = await register();
    }

    result.fold(_onError, (r) {
      NavUtils.loadFromMainRoute();
      return;
    });
  }

  void _onError(AuthFailure l) {
    var msgToShow = 'unknown error';
    l.when(weakPassword: () {
      msgToShow = 'weakPassword';
    }, emailAlreadyInUse: () {
      msgToShow = 'emailAlreadyInUse';
    }, custom: (String x) {
      msgToShow = x;
    });
    debugPrint('error $msgToShow');
    Get.snackbar<void>('error', msgToShow);
  }
}
