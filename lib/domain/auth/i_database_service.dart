import 'dart:async';

import 'package:terndy_movies/domain/auth/auth_user_model.dart';

mixin AuthDataBaseMix {
  Future<AuthUserModel> restoreUserAuth();
  Future<void> saveUserAuth(AuthUserModel userAuthModel);
}
