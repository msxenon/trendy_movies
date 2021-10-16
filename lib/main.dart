import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:trendy_movies/src/application/utils/error_catcher/error_catcher.dart';
import 'package:trendy_movies/src/dependencies_container.dart';
import 'package:trendy_movies/src/presentation/main_app/trendy_app.dart';

void main() {
  _startUp();
}

Future<void> _startUp() async {
  await DependenciesContainer().init();
  ErrorCatcher(_runApp);
}

Future<void> _runApp() async {
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      systemNavigationBarColor: Colors.transparent,
      statusBarColor: Colors.transparent,
    ),
  );
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
  final delegate = await LocalizationDelegate.create(
    fallbackLocale: 'en_US',
    supportedLocales: ['en_US'],
  );
  runApp(LocalizedApp(delegate, TrendyApp()));
}
