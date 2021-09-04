import 'package:hive_flutter/hive_flutter.dart';
import 'package:terndy_movies/domain/auth/auth_user_model.dart';
import 'package:terndy_movies/domain/database.dart';

class DatabaseServiceImpl extends DatabaseService {
  late Box<Map<String, dynamic>>? _anonymousBox;
  Box<Map<String, dynamic>> get anonymousBox => _anonymousBox!;
  static const _userModelKey = 'userModel';

  @override
  Future<AuthUserModel> restoreUserAuth() async {
    final userModelMap = anonymousBox.get(_userModelKey);
    if (userModelMap == null) {
      return const AuthUserModel.notLoggedIn();
    }
    return AuthUserModel.fromJson(userModelMap);
  }

  @override
  Future<void> saveUserAuth(AuthUserModel userAuthModel) {
    return anonymousBox.put(_userModelKey, userAuthModel.toJson());
  }

  @override
  Future<void> initDb() async {
    await Hive.initFlutter();
    _anonymousBox = await Hive.openBox<Map<String, dynamic>>('anonymous_box');
    return;
  }
}
