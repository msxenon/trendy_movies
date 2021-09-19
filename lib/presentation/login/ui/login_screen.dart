import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:terndy_movies/application/localisation/keys.dart';
import 'package:terndy_movies/presentation/login/logic/login_controller.dart';
import 'package:terndy_movies/presentation/login/ui/submit_button.dart';
import 'package:terndy_movies/presentation/login/ui/toggle_button.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<LoginController>(
        builder: (controller) => Center(
          child: AutofillGroup(
            child: ListView(
              shrinkWrap: true,
              children: [
                if (controller.viewState.value.isRegister)
                  TextField(
                    autofillHints: const [AutofillHints.name],
                    keyboardType: TextInputType.name,
                    controller: controller.displayNameController,
                    decoration: InputDecoration(
                      hintText: Keys.User_Display_Name.trans,
                      errorText: controller.validateDisplayName(),
                    ),
                  ),
                TextField(
                  autofillHints: const [AutofillHints.email],
                  keyboardType: TextInputType.emailAddress,
                  controller: controller.emailController,
                  decoration: InputDecoration(
                    hintText: Keys.User_Email.trans,
                    errorText: controller.validateEmail(),
                  ),
                ),
                TextField(
                  autofillHints: const [AutofillHints.password],
                  keyboardType: TextInputType.visiblePassword,
                  controller: controller.passwordController,
                  obscureText: true,
                  decoration: InputDecoration(
                    hintText: Keys.User_Password.trans,
                    errorText: controller.validatePassword(),
                  ),
                ),
                const SubmitButton(),
                const ToggleButton(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
