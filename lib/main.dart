import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:terndy_movies/dependencies_container.dart';
import 'package:terndy_movies/home/home_screen.dart';

import 'login/logic/login_screen_bindings.dart';
import 'login/ui/login_screen.dart';

void main() async {
  await DependenciesContainer().onAppLaunch();
  runApp(MyApp());
}

class MyApp extends StatelessWidget with BaseToolBox {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      getPages: [
        GetPage(
            name: '/',
            page: () {
              return authService.hasLoggedIn ? HomeScreen() : LoginScreen();
            },
            bindings: [
              authService.hasLoggedIn
                  ? HomeScreenBindings()
                  : LoginScreenBindings(),
            ])
      ],
      enableLog: true,
    );
  }
}
