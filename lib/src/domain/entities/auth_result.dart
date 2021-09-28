import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:trendy_movies/src/data/models/auth_user_model.dart';

part 'auth_result.freezed.dart';

@freezed
class AuthRegisterResult with _$AuthRegisterResult {
  const factory AuthRegisterResult.success(String token) = AuthResultSuccess;
  const factory AuthRegisterResult.error(AuthRegisterError error) =
      AuthResultError;
}

@freezed
class AuthSignInResult with _$AuthSignInResult {
  const factory AuthSignInResult.success(AuthUserModel authUserModel) =
      AuthSignInResultSuccess;
  const factory AuthSignInResult.error(String error) = AuthSignInResultError;
}

@freezed
class AuthRegisterError with _$AuthRegisterError {
  const factory AuthRegisterError.weakPassword() = AuthErrorWeakPassword;
  const factory AuthRegisterError.emailAlreadyInUse() =
      AuthErrorEmailAlreadyInUse;
  const factory AuthRegisterError.custom(String error) = AuthErrorCustom;
}
