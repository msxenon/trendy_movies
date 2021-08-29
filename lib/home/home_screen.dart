import 'package:flutter/material.dart';
import 'package:terndy_movies/dependencies_container.dart';

import 'trendy_movies_page.dart';

class HomeScreen extends StatelessWidget with BaseToolBox {
  HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Welcome ${authService.user.email}'),
      ),
      body: TrendyMoviesPage(),
    );
  }
}
