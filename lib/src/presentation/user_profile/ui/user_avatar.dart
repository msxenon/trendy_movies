import 'package:colorize_text_avatar/colorize_text_avatar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:trendy_movies/src/application/utils/app_routes.dart';
import 'package:trendy_movies/src/domain/base_dependency_container.dart';

class UserAvatar extends StatelessWidget with BaseToolBox {
  const UserAvatar({this.size, this.clickable = true, Key? key})
      : super(key: key);
  final double? size;
  final bool clickable;
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: InkWell(
        onTap:
            clickable ? () => Get.toNamed<void>(AppRoutes.userProfile) : null,
        child: Obx(
          () => TextAvatar(
            text: authService.signedInUserModel.value.displayName,
            shape: Shape.Circular,
            numberLetters: 2,
            size: size,
          ),
        ),
      ),
    );
  }
}
