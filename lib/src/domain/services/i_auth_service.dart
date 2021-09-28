import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:trendy_movies/src/data/models/auth_user_model.dart';
import 'package:trendy_movies/src/domain/entities/auth_entity.dart';
import 'package:trendy_movies/src/domain/entities/auth_result.dart';
import 'package:trendy_movies/src/domain/services/base_service.dart';

abstract class AuthRepo extends BaseService {
  //Notifies when the authentication status changes.
  final Rx<AuthUserModel> authStateChanges = _notLoggedIn.obs;
  Rx<SignedInUserModel> get signedInUserModel =>
      (authStateChanges.value.mapOrNull(signedIn: (s) => s) ??
              const SignedInUserModel(displayName: 'unknown', id: '00000'))
          .obs;
  bool get isLoggedIn => authStateChanges.value != _notLoggedIn;
  static const _notLoggedIn = AuthUserModel.unknown();
  //Logs out from the service.
  @mustCallSuper
  Future<void> signOut() async {
    authStateChanges(_notLoggedIn);
  }

  void navigateOnSignedIn();

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
