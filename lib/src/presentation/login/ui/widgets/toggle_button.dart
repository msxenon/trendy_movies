import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:trendy_movies/src/presentation/login/logic/login_controller.dart';

class ToggleButton extends GetView<LoginController> {
  const ToggleButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: controller.toggleLogin,
      child: Text(controller.toggleText),
    );
  }
}
