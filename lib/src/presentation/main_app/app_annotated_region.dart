import 'package:flutter/material.dart';

class AppAnnotatedRegion extends StatelessWidget {
  const AppAnnotatedRegion({this.child, Key? key}) : super(key: key);

  final Widget? child;
  @override
  Widget build(BuildContext context) {
    return child ?? const SizedBox.shrink();
    // return AnnotatedRegion<SystemUiOverlayStyle>(
    //   key: const Key('e'),
    //   value: SystemUiOverlayStyle.light,
    //   // value: !Get.isDarkMode
    //   //     ? SystemUiOverlayStyle.dark
    //   //     : SystemUiOverlayStyle.light
    //   //         .copyWith(systemNavigationBarColor: Colors.white),
    //   child: child ?? const SizedBox.shrink(),
    // );
  }
}
