import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:trendy_movies/src/application/utils/nav_utils.dart';
import 'package:trendy_movies/src/data/models/auth_user_model.dart';
import 'package:trendy_movies/src/domain/entities/auth_entity.dart';
import 'package:trendy_movies/src/domain/entities/auth_result.dart';
import 'package:trendy_movies/src/domain/services/i_auth_service.dart';

class FirebaseAuthService extends AuthRepo {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  bool _isLoggedIn = false;
  @override
  void onInit() {
    _userStateListener();
    super.onInit();
  }

  void _userStateListener() {
    _auth.userChanges().listen(
      (User? user) {
        if (user == null) {
          authStateChanges(const AuthUserModel.unknown());
        } else {
          final userAuthModel = AuthUserModel.signedIn(
            id: user.uid,
            displayName: _getDisplayNameFromUser(user) ?? 'Unknown',
          );
          authStateChanges(userAuthModel);
        }
      },
    );

    ever(authStateChanges, (callback) {
      if (_isLoggedIn == isLoggedIn) {
        return;
      }
      _isLoggedIn = isLoggedIn;
      if (isLoggedIn) {
        navigateOnSignedIn();
      } else {
        onSignOut();
      }
    });
  }

  @override
  Future<AuthRegisterResult> registerWithEmail(
    RegisterEntity registerEntity,
  ) async {
    try {
      final user = await _auth.createUserWithEmailAndPassword(
        email: registerEntity.email,
        password: registerEntity.password,
      );
      await updateDisplayName(registerEntity.displayName);
      final token = user.user!.refreshToken!;

      return AuthRegisterResult.success(
        token,
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        return const AuthRegisterResult.error(
          AuthRegisterError.weakPassword(),
        );
      } else if (e.code == 'email-already-in-use') {
        return const AuthRegisterResult.error(
          AuthRegisterError.emailAlreadyInUse(),
        );
      } else {
        return AuthRegisterResult.error(
          AuthRegisterError.custom(e.message ?? e.code),
        );
      }
    } catch (e, s) {
      logger.error(error: e, stackTrace: s);

      return AuthRegisterResult.error(
        AuthRegisterError.custom(
          e.toString(),
        ),
      );
    }
  }

  @override
  Future<AuthSignInResult> signInWithEmail(
    SignInEntity emailSignInEntity,
  ) async {
    try {
      final user = await _auth.signInWithEmailAndPassword(
        email: emailSignInEntity.email,
        password: emailSignInEntity.password,
      );
      final userModel = AuthUserModel.signedIn(
        id: user.user!.uid,
        displayName: _getDisplayNameFromCreds(user),
      );

      return AuthSignInResult.success(
        userModel,
      );
    } on FirebaseAuthException catch (e) {
      return AuthSignInResult.error(
        e.message ?? e.code,
      );
    } catch (e, s) {
      logger.error(error: e, stackTrace: s);

      return AuthSignInResult.error(
        e.toString(),
      );
    }
  }

  @override
  Future<AuthSignInResult> signInWithToken(String token) async {
    try {
      final user = await _auth.signInWithCustomToken(token);

      final userModel = AuthUserModel.signedIn(
        id: user.user!.uid,
        displayName: _getDisplayNameFromCreds(user),
      );

      return AuthSignInResult.success(
        userModel,
      );
    } on FirebaseAuthException catch (e) {
      return AuthSignInResult.error(
        e.message ?? e.code,
      );
    } catch (e, s) {
      logger.error(error: e, stackTrace: s);

      return AuthSignInResult.error(
        e.toString(),
      );
    }
  }

  @override
  Future<void> signOut() async {
    await _auth.signOut();
    await super.signOut();
  }

  void onSignOut() {
    loadFromMainRoute();
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
  Future<void> updateDisplayName(
    String displayName, {
    bool refreshUI = false,
  }) async {
    await _auth.currentUser?.updateDisplayName(displayName);

    return;
  }

  @override
  void navigateOnSignedIn() {
    continueAsLoggedIn();
  }
}
