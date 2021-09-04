import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:terndy_movies/domain/auth/auth_failure.dart';
import 'package:terndy_movies/domain/auth/auth_user_model.dart';
import 'package:terndy_movies/domain/base_service.dart';

abstract class AuthService extends BaseService {
  //Notifies when the authentication status changes.
  Rx<AuthUserModel> get authStateChanges =>
      const AuthUserModel.notLoggedIn().obs;
  bool get isLoggedIn =>
      authStateChanges.value != const AuthUserModel.notLoggedIn();
  //Logs out from the service.
  @mustCallSuper
  Future<void> signOut() async {
    authStateChanges(const AuthUserModel.notLoggedIn());
  }

  @override
  void onInit() {
    onLaunch();
    super.onInit();
  }

  @mustCallSuper
  Future<void> onLaunch() async {
    authStateChanges(await database.restoreUserAuth());
  }

  @protected
  Future<Either<AuthFailure, AuthUserModel>> signInWithEmailExc({
    required String email,
    required String password,
  });
  @protected
  Future<Either<AuthFailure, AuthUserModel>> registerWithEmailExc({
    required String email,
    required String password,
  });
  @mustCallSuper
  Future<Either<AuthFailure, void>> signInWithEmail({
    required String email,
    required String password,
  }) async {
    final signingIn =
        await signInWithEmailExc(email: email, password: password);
    return signingIn.fold((l) => Left(l), onSignInSuccess);
  }

  @mustCallSuper
  Future<Either<AuthFailure, void>> registerWithEmail({
    required String email,
    required String password,
  }) async {
    final register =
        await registerWithEmailExc(email: email, password: password);
    return register.fold((l) => Left(l), onSignInSuccess);
  }

  @mustCallSuper
  FutureOr<Either<AuthFailure, void>> onSignInSuccess(AuthUserModel r) {
    authStateChanges(const AuthUserModel.notLoggedIn());
    return Future.value();
  }
}
