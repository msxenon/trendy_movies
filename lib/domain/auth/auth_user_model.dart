import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:terndy_movies/database/hive_adapters_ids.dart';

part 'auth_user_model.freezed.dart';
part 'auth_user_model.g.dart';

@freezed
class AuthUserModel with _$AuthUserModel {
  @HiveType(
      typeId: HiveAdaptersData.authUserModelTid,
      adapterName: HiveAdaptersData.authUserModelName)
  const factory AuthUserModel.loggedIn({
    @HiveField(0) required String id,
    @HiveField(1) required String displayName,
  }) = _AuthUserModel;
  const factory AuthUserModel.notLoggedIn() = _noLoggedIn;
  factory AuthUserModel.fromJson(Map<String, dynamic> json) =>
      _$AuthUserModelFromJson(json);
}
