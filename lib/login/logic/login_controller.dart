import 'package:get/get.dart';

class AuthService extends GetxService {
  final RxBool _hasLoggedIn = false.obs;
  bool get hasLoggedIn => _hasLoggedIn.value;
}
