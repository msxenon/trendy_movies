import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class AppAnnotatedRegion extends StatelessWidget {
  const AppAnnotatedRegion({this.child, Key? key}) : super(key: key);
  final Widget? child;
  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: !Get.isDarkMode
          ? SystemUiOverlayStyle.dark
          : SystemUiOverlayStyle.light
              .copyWith(systemNavigationBarColor: Colors.white),
      child: child ?? const SizedBox.shrink(),
    );
  }
}
