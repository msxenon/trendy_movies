import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:terndy_movies/domain/auth/auth_entity.dart';
import 'package:terndy_movies/domain/auth/auth_result.dart';
import 'package:terndy_movies/domain/auth/auth_user_model.dart';
import 'package:terndy_movies/domain/base_service.dart';

abstract class AuthService extends BaseService {
  //Notifies when the authentication status changes.
  final Rx<AuthUserModel> authStateChanges = _notLoggedIn.obs;
  SignedInUserModel get signedInUserModel =>
      authStateChanges.value.mapOrNull(signedIn: (s) => s)!;
  bool get isLoggedIn => authStateChanges.value != _notLoggedIn;
  static const _notLoggedIn = AuthUserModel.unknown();
  //Logs out from the service.
  @mustCallSuper
  Future<void> signOut() async {
    authStateChanges(_notLoggedIn);
  }

  @override
  void onInit() {
    onLaunch();
    super.onInit();
  }

  @mustCallSuper
  Future<void> onLaunch() async {
    authStateChanges(database.restoreUserAuth());
  }

  Future<AuthRegisterResult> registerWithEmail(
    RegisterEntity registerEntity,
  );

  Future<AuthSignInResult> signInWithToken(
    String token,
  );

  Future<AuthSignInResult> signInWithEmail(
    SignInEntity emailSignInEntity,
  );

  Future<void> updateDisplayName(String displayName, {bool refreshUI = false});
}
