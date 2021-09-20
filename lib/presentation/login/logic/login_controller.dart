import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:trendy_movies/application/localisation/keys.dart';
import 'package:trendy_movies/domain/auth/auth_entity.dart';
import 'package:trendy_movies/domain/auth/auth_result.dart';
import 'package:trendy_movies/domain/base_dependency_container.dart';
import 'package:trendy_movies/presentation/main_app/trendy_app.dart';

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

  String get toggleText => viewState.value.isLogin
      ? Keys.Actions_Q_Not_Registered_Yet.trans
      : Keys.Actions_Q_Already_Signed_Up.trans;
  String get submitText => viewState.value.isLogin
      ? Keys.Actions_Sign_In.trans
      : Keys.Actions_Sign_Up.trans;
  Future<AuthSignInResult> _signIn() async {
    update();
    if (!_validateLogin()) {
      return AuthSignInResult.error(Keys.Errors_All_Fields_Val.trans);
    }

    return authService.signInWithEmail(
      SignInEntity(
        email: emailController.text,
        password: passwordController.text,
      ),
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
      return Keys.Errors_Password_Empty.trans;
    }

    return null;
  }

  String? validateEmail() {
    if (!emailController.text.isEmail) {
      return Keys.Errors_Email_Val.trans;
    }

    return null;
  }

  String? validateDisplayName() {
    if (displayNameController.text.isEmpty ||
        !displayNameController.text.isAlphabetOnly) {
      return Keys.Errors_Display_Name_Val.trans;
    }

    return null;
  }

  void toggleLogin() {
    if (viewState.value.isLogin) {
      viewState(LoginViewState.register);
      setPageTitle(Keys.Actions_Sign_Up.trans);
    } else {
      viewState(LoginViewState.login);
      setPageTitle(Keys.Actions_Sign_In.trans);
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
    var msgToShow = Keys.Errors_Unknown.trans;
    l.when(
      weakPassword: () {
        msgToShow = Keys.Errors_Weak_Password.trans;
      },
      emailAlreadyInUse: () {
        msgToShow = Keys.Errors_Email_Already_In_Use.trans;
      },
      custom: (String x) {
        msgToShow = x;
      },
    );
    logger.debug(msgToShow);

    Get.snackbar<void>(Keys.Errors_Error.trans, msgToShow);
  }

  Future<void> _onSignIn() async {
    final signInResult = await _signIn();
    signInResult.whenOrNull(
      error: (e) {
        Get.snackbar<void>(Keys.Errors_Error.trans, e);
      },
    );
  }

  Future<AuthRegisterResult> _register() async {
    update();
    if (!_validateRegister()) {
      return AuthRegisterResult.error(
        AuthRegisterError.custom(
          Keys.Errors_All_Fields_Val.trans,
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
        signIn.whenOrNull(
          error: (e) {
            Get.snackbar<void>(Keys.Errors_Error.trans, e);
          },
        );
      },
      error: (e) => _onError,
    );
  }
}
