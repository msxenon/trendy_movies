import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:terndy_movies/dependencies_container.dart';
import 'package:terndy_movies/login/logic/login_constants.dart';

class AuthService extends GetxService with BaseToolBox {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  final RxBool _hasLoggedIn = false.obs;
  bool get hasLoggedIn => _hasLoggedIn.value;
  User? _user;
  User get user => _user!;
  @override
  void onInit() {
    ever(_hasLoggedIn, (_) {
      // Get.offNamed(
      //   '/',
      // );
    });
    _onAppLaunch();
    super.onInit();
  }

  void _onAppLaunch() async {
    _hasLoggedIn.value =
        database.anonymousBox.get(LoginConstants.tokenKey) != null;

    _auth.userChanges().listen((User? user) {
      _user = user;

      if (_user == null) {
        _hasLoggedIn(false);
        print('User is currently signed out!');
      } else {
        database.anonymousBox.put(LoginConstants.tokenKey, user!.uid);
        print('User is signed in!');
      }
    });
  }

  Future<Either<String, bool>> register(String email, String password) async {
    try {
      await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      return Right(true);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        return Left('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        return Left('The account already exists for that email.');
      } else {
        return Left(e.message ?? e.code);
      }
    } catch (e) {
      return Left(e.toString());
    }
  }

  Future<Either<String, bool>> login(String email, String password) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);

      return Right(true);
    } on FirebaseAuthException catch (e) {
      return Left(e.message ?? e.code);
    } catch (e) {
      return Left(e.toString());
    }
  }
}
