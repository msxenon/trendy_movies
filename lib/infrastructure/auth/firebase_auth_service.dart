import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
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
            id: user.uid, displayName: user.displayName!);
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
            displayName: user.additionalUserInfo!.username!),
      );
    } on FirebaseAuthException catch (e) {
      return Left(
        AuthFailure.custom(e.message ?? e.code),
      );
    } catch (e) {
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
  Future<Either<AuthFailure, AuthUserModel>> registerWithEmailExc(
      {required String email, required String password}) async {
    try {
      final user = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      return Right(
        AuthUserModel.loggedIn(
            id: user.user!.uid,
            displayName: user.additionalUserInfo!.username!),
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
    } catch (e) {
      return Left(
        AuthFailure.custom(
          e.toString(),
        ),
      );
    }
  }
}
