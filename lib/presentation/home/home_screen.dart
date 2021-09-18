import 'package:flutter/material.dart';
import 'package:terndy_movies/domain/base_dependency_container.dart';
 import 'package:terndy_movies/presentation/home/trendy_movies_page.dart';

class HomeScreen extends StatelessWidget with BaseToolBox {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
            'Welcome ${authService.authStateChanges.value.mapOrNull(loggedIn: (e) => e.displayName)}'),
      ),
      body: const TrendyMoviesPage(),
    );
  }
}
