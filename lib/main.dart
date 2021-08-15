import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:terndy_movies/login/logic/login_controller.dart';

void main() async {
  await setupDeps();
  runApp(MyApp());
}

Future<void> setupDeps() async {
  Get..put(AuthService());
  return;
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(getPages: [
      GetPage(
          name: '/',
          page: () {
            return box.hasData('token') ? Home() : Login();
          })
    ]);
  }
}
