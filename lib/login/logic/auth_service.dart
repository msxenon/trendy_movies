import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:terndy_movies/dependencies_container.dart';
import 'package:terndy_movies/login/logic/login_constants.dart';

class AuthService extends GetxService with BaseToolBox {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  final RxBool _hasLoggedIn = false.obs;
  bool get hasLoggedIn => _hasLoggedIn.value;
  User? _user;

  void onAppLaunch() async {
    _hasLoggedIn.value =
        database.anonymousBox.get(LoginConstants.tokenKey) != null;

    _auth.userChanges().listen((User? user) {
      _user = user;

      if (_user == null) {
        _hasLoggedIn(false);
        print('User is currently signed out!');
      } else {
        print('User is signed in!');
      }
    });
  }

  Future<void> register(String email, String password) async {
    try {
      UserCredential userCredential = await _auth
          .createUserWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }
    } catch (e) {
      print(e);
    }
  }
}
