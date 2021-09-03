import 'package:freezed_annotation/freezed_annotation.dart';

part 'auth_user_model.freezed.dart';
part 'auth_user_model.g.dart';

@freezed
class AuthUserModel with _$AuthUserModel {
  const factory AuthUserModel.loggedIn({
    required String id,
    required String displayName,
  }) = _AuthUserModel;
  const factory AuthUserModel.notLoggedIn() = _noLoggedIn;
  factory AuthUserModel.fromJson(Map<String, dynamic> json) =>
      _$AuthUserModelFromJson(json);
}
