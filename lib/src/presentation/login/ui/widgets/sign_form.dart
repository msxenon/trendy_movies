import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:trendy_movies/src/application/localisation/keys.dart';
import 'package:trendy_movies/src/presentation/login/logic/login_controller.dart';
import 'package:trendy_movies/src/presentation/login/ui/widgets/submit_button.dart';
import 'package:trendy_movies/src/presentation/login/ui/widgets/toggle_button.dart';

class SignForm extends GetView<LoginController> {
  const SignForm({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        margin: const EdgeInsets.symmetric(horizontal: 10).copyWith(top: 20),
        decoration: ShapeDecoration(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(
              10,
            ),
          ),
          color: const Color(0x280074FF),
        ),
        child: _column(),
      );
    });
  }

  Widget _column() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          controller.viewState.value.isLogin
              ? Keys.Actions_Sign_In.trans
              : Keys.Actions_Sign_Up.trans,
          style: Theme.of(Get.context!).textTheme.headline5,
        ),
        const SizedBox(
          height: 10,
        ),
        ..._textFields(),
        const SizedBox(
          height: 10,
        ),
        const SubmitButton(),
        ToggleButton(
          key: controller.viewState.value.isLogin
              ? Key(Keys.Actions_Sign_In.trans)
              : Key(Keys.Actions_Sign_Up.trans),
        ),
      ],
    );
  }

  List<Widget> _textFields() {
    return [
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
    ];
  }
}
