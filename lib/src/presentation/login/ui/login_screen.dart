import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:trendy_movies/src/application/widgets/app_logo.dart';
import 'package:trendy_movies/src/presentation/login/logic/login_controller.dart';
import 'package:trendy_movies/src/presentation/login/ui/widgets/sign_form.dart';

class LoginScreen extends GetResponsiveView<LoginController> {
  LoginScreen({Key? key}) : super(key: key);
  @override
  bool get alwaysUseBuilder => true;
  @override
  Widget? phone() {
    return Column(
      children: const [
        AppLogo(
          showAppName: true,
        ),
        SignForm(),
      ],
    );
  }

  @override
  Widget? desktop() {
    return Row(
      children: const [
        AppLogo(
          showAppName: true,
        ),
        SignForm(),
      ],
    );
  }

  @override
  Widget? builder() {
    return Scaffold(
      body: GetBuilder<LoginController>(
        builder: (controller) => Center(
          child: SingleChildScrollView(
            child: AutofillGroup(
              child: screen.isDesktop ? desktop()! : phone()!,
            ),
          ),
        ),
      ),
    );
  }
}
