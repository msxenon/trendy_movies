import 'package:colorize_text_avatar/colorize_text_avatar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:trendy_movies/domain/base_dependency_container.dart';

class UserAvatar extends StatelessWidget with BaseToolBox {
  const UserAvatar({this.size, Key? key}) : super(key: key);
  final double? size;
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => TextAvatar(
        text: authService.signedInUserModel.value.displayName,
        shape: Shape.Circular,
        numberLetters: 2,
        size: size,
      ),
    );
  }
}
