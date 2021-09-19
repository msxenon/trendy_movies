import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:trendy_movies/presentation/login/logic/login_controller.dart';

class SubmitButton extends GetView<LoginController> {
  const SubmitButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: controller.submit,
      child: Text(controller.submitText),
    );
  }
}
