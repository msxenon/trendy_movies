import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:hive/hive.dart';
import 'package:terndy_movies/database/hive_adapters_ids.dart';
import 'package:terndy_movies/domain/auth/auth_user_model.dart';

mixin AuthDataBaseMix {
  late Box<AuthUserModel> _authBox;

  @mustCallSuper
  AuthUserModel restoreUserAuth() {
    return _authBox.get(0, defaultValue: const AuthUserModel.unknown())!;
  }

  void registerAuthAdapter() {
    Hive.registerAdapter(AuthUserModelAdapter());
  }

  @mustCallSuper
  Future<void> saveUserAuth(AuthUserModel userAuthModel) {
    return _authBox.put(0, userAuthModel);
  }

  Future<void> openAuthAdapter() async {
    _authBox =
        await Hive.openBox<AuthUserModel>(HiveAdaptersData.authUserModelName);
  }

  Future<void> closeAuthAdapter() async {
    await _authBox.close();
  }
}
