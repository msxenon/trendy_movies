import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:terndy_movies/dependencies_container.dart';
import 'package:terndy_movies/domain/base_dependency_container.dart';
import 'package:terndy_movies/home/home_screen.dart';
import 'package:terndy_movies/presentation/login/logic/login_screen_bindings.dart';
import 'package:terndy_movies/presentation/login/ui/login_screen.dart';

void main() {
  _startUp();
}

Future<void> _startUp() async {
  WidgetsFlutterBinding.ensureInitialized();

  await DependenciesContainer().setupMainServices();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget with BaseToolBox {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      getPages: [
        GetPage<void>(
            name: '/',
            page: () {
              return authService.isLoggedIn
                  ? const HomeScreen()
                  : const LoginScreen();
            },
            bindings: [
              if (authService.isLoggedIn)
                HomeScreenBindings()
              else
                LoginScreenBindings(),
            ])
      ],
      enableLog: true,
    );
  }
}
