import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:trendy_movies/src/application/widgets/app_logo.dart';
import 'package:trendy_movies/src/presentation/login/logic/login_controller.dart';
import 'package:trendy_movies/src/presentation/login/ui/widgets/sign_form.dart';

class LoginScreen extends GetResponsiveView<LoginController> {
  LoginScreen({Key? key})
      : super(
          alwaysUseBuilder: true,
          key: key,
        );

  @override
  Widget? phone() {
    return SingleChildScrollView(
      child: Column(
        children: const [
          AppLogo(
            showAppName: true,
          ),
          SignForm(),
        ],
      ),
    );
  }

  @override
  Widget? desktop() {
    return Row(
      children: const [
        Expanded(
          child: AppLogo(
            showAppName: true,
          ),
        ),
        Flexible(
          child: SignForm(),
        ),
        SizedBox(
          width: 20,
        ),
      ],
    );
  }

  @override
  Widget? builder() {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: AutofillGroup(
            child: screen.isDesktop ? desktop()! : phone()!,
          ),
        ),
      ),
    );
  }
}
