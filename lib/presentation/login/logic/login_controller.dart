import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:terndy_movies/domain/auth/auth_entity.dart';
import 'package:terndy_movies/domain/auth/auth_result.dart';
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

  Future<AuthSignInResult> _signIn() async {
    update();
    if (!_validateLogin()) {
      return const AuthSignInResult.error('All Fields are required!');
    }
    return authService.signInWithEmail(
      SignInEntity(
          email: emailController.text, password: passwordController.text),
    );
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

  void submit() {
    if (viewState.value.isLogin) {
      _onSignIn();
    } else {
      _onRegisterWithAutoSignIn();
    }
  }

  void _onError(AuthRegisterError l) {
    var msgToShow = 'unknown error';
    l.when(weakPassword: () {
      msgToShow = 'weakPassword';
    }, emailAlreadyInUse: () {
      msgToShow = 'emailAlreadyInUse';
    }, custom: (String x) {
      msgToShow = x;
    });
    logger.debug(msgToShow);

    Get.snackbar<void>('error', msgToShow);
  }

  Future<void> _onSignIn() async {
    final signInResult = await _signIn();
    signInResult.when(
        success: (s) {},
        error: (e) {
          Get.snackbar<void>('error', e);
        });
  }

  Future<AuthRegisterResult> _register() async {
    update();
    if (!_validateRegister()) {
      return const AuthRegisterResult.error(
        AuthRegisterError.custom(
          'All Fields are required!',
        ),
      );
    }
    return authService.registerWithEmail(
      RegisterEntity(
        email: emailController.text,
        password: passwordController.text,
        displayName: displayNameController.text,
      ),
    );
  }

  Future<void> _onRegisterWithAutoSignIn() async {
    final register = await _register();

    register.when(
      success: (token) async {
        final signIn = await authService.signInWithToken(token);
        signIn.when(
          success: (s) {},
          error: (e) {
            Get.snackbar<void>('error', e);
          },
        );
      },
      error: (e) => _onError,
    );
  }
}
