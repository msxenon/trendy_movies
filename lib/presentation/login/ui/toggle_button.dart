import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:terndy_movies/presentation/login/logic/login_controller.dart';

class ToggleButton extends GetView<LoginController> {
  const ToggleButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: controller.toggleLogin,
      child: Text(controller.toggleText),
    );
  }
}
