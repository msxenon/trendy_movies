import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:terndy_movies/domain/auth/auth_failure.dart';
import 'package:terndy_movies/domain/auth/auth_user_model.dart';
import 'package:terndy_movies/domain/auth/i_auth_service.dart';

class FirebaseAuthService extends AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  @override
  void onInit() {
    _userStateListener();
    super.onInit();
  }

  void _userStateListener() {
    _auth.userChanges().listen((User? user) {
      if (user == null) {
        authStateChanges(const AuthUserModel.notLoggedIn());
      } else {
        final userAuthModel = AuthUserModel.loggedIn(
          id: user.uid,
          displayName: _getDisplayNameFromUser(user) ?? 'Unknown',
        );
        database.saveUserAuth(userAuthModel);
        authStateChanges(userAuthModel);
      }
    });
  }

  @override
  Future<Either<AuthFailure, AuthUserModel>> signInWithEmailExc(
      {required String email, required String password}) async {
    try {
      final user = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      return Right(
        AuthUserModel.loggedIn(
          id: user.user!.uid,
          displayName: _getDisplayNameFromCreds(user),
        ),
      );
    } on FirebaseAuthException catch (e) {
      return Left(
        AuthFailure.custom(e.message ?? e.code),
      );
    } catch (e, s) {
      debugPrint('$e $s');
      return Left(
        AuthFailure.custom(
          e.toString(),
        ),
      );
    }
  }

  @override
  Future<void> signOut() async {
    await _auth.signOut();
    await super.signOut();
  }

  @override
  Future<Either<AuthFailure, AuthUserModel>> registerWithEmailExc({
    required String email,
    required String password,
    required String displayName,
  }) async {
    try {
      final user = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      await _auth.currentUser?.updateDisplayName(displayName);
      await signInWithToken(token: user.user!.refreshToken!);
      return Right(
        AuthUserModel.loggedIn(id: user.user!.uid, displayName: displayName),
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        return const Left(
          AuthFailure.weakPassword(),
        );
      } else if (e.code == 'email-already-in-use') {
        return const Left(
          AuthFailure.emailAlreadyInUse(),
        );
      } else {
        return Left(
          AuthFailure.custom(e.message ?? e.code),
        );
      }
    } catch (e, s) {
      debugPrint('$e $s');
      return Left(
        AuthFailure.custom(
          e.toString(),
        ),
      );
    }
  }

  String _getDisplayNameFromCreds(UserCredential user) {
    return _getDisplayNameFromUser(user.user) ??
        user.additionalUserInfo?.username ??
        user.user?.email ??
        'Unknown user name';
  }

  String? _getDisplayNameFromUser(User? user) {
    return user?.displayName;
  }

  @override
  Future<Either<AuthFailure, AuthUserModel>> signInWithTokenExc(
      {required String token}) async {
    try {
      final user = await _auth.signInWithCustomToken(token);
      return Right(
        AuthUserModel.loggedIn(
          id: user.user!.uid,
          displayName: _getDisplayNameFromCreds(user),
        ),
      );
    } on FirebaseAuthException catch (e) {
      return Left(
        AuthFailure.custom(e.message ?? e.code),
      );
    } catch (e, s) {
      debugPrint('$e $s');
      return Left(
        AuthFailure.custom(
          e.toString(),
        ),
      );
    }
  }
}
