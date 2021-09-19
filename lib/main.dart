import 'package:flutter/material.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:terndy_movies/dependencies_container.dart';
import 'package:terndy_movies/presentation/main_app/trendy_app.dart';

void main() {
  _startUp();
}

Future<void> _startUp() async {
  final delegate = await LocalizationDelegate.create(
    fallbackLocale: 'en_US',
    supportedLocales: ['en_US'],
  );
  await DependenciesContainer().init();
  runApp(LocalizedApp(delegate, TrendyApp()));
}
