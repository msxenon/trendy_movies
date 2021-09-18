class SignInEntity {
  const SignInEntity({required this.email, required this.password});

  final String email;
  final String password;
}

class RegisterEntity {
  const RegisterEntity(
      {required this.email, required this.password, required this.displayName});
  final String email;
  final String password;
  final String displayName;
}
