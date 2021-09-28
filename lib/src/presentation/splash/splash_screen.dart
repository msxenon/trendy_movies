import 'package:flutter/material.dart';
import 'package:trendy_movies/src/domain/base_dependency_container.dart';

class SplashScreen extends StatelessWidget with BaseToolBox {
  const SplashScreen({Key? key, this.showLoading = false, this.textToDisplay})
      : super(key: key);
  final bool showLoading;
  final String? textToDisplay;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(
              height: 30,
            ),
            if (showLoading)
              const CircularProgressIndicator(
                color: Colors.white,
              ),
            if (textToDisplay != null)
              Text(
                textToDisplay!,
                style: Theme.of(context).textTheme.headline4,
              ),
          ],
        ),
      ),
    );
  }
}
