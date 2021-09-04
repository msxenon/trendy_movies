import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:terndy_movies/domain/auth/auth_failure.dart';
import 'package:terndy_movies/domain/auth/auth_user_model.dart';
import 'package:terndy_movies/domain/base_service.dart';

abstract class AuthService extends BaseService {
  //Notifies when the authentication status changes.
  Rx<AuthUserModel> authStateChanges = _notLoggedIn.obs;
  bool get isLoggedIn => authStateChanges.value != _notLoggedIn;
  static const _notLoggedIn = AuthUserModel.notLoggedIn();
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

  @protected
  Future<Either<AuthFailure, AuthUserModel>> signInWithEmailExc({
    required String email,
    required String password,
  });
  @protected
  Future<Either<AuthFailure, AuthUserModel>> signInWithTokenExc({
    required String token,
  });
  Future<Either<AuthFailure, String>> signInWithToken({
    required String token,
  }) async {
    final user = await signInWithTokenExc(token: token);
    return user.fold((l) => Left(l), onSignInSuccess);
  }

  @protected
  Future<Either<AuthFailure, AuthUserModel>> registerWithEmailExc({
    required String email,
    required String password,
    required String displayName,
  });
  @mustCallSuper
  Future<Either<AuthFailure, String>> signInWithEmail({
    required String email,
    required String password,
  }) async {
    final signingIn =
        await signInWithEmailExc(email: email, password: password);
    return signingIn.fold((l) => Left(l), onSignInSuccess);
  }

  @mustCallSuper
  Future<Either<AuthFailure, String>> registerWithEmail({
    required String email,
    required String password,
    required String displayName,
  }) async {
    final register = await registerWithEmailExc(
      email: email,
      password: password,
      displayName: displayName,
    );
    return register.fold((l) => Left(l), onSignInSuccess);
  }

  @mustCallSuper
  Future<Either<AuthFailure, String>> onSignInSuccess(AuthUserModel r) async {
    authStateChanges(r);

    return const Right('Done');
  }
}
