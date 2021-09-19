import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:trendy_movies/application/localisation/keys.dart';
import 'package:trendy_movies/domain/base_dependency_container.dart';

class UserProfileController extends GetxController with BaseToolBox {
  late final TextEditingController displayNameController =
      TextEditingController(text: _initialDisplayName);
  late final String _initialDisplayName =
      authService.signedInUserModel.value.displayName;
  late bool isDarkTheme;
  @override
  void onInit() {
    isDarkTheme = Get.isDarkMode;
    super.onInit();
  }

  Future<void> saveChanges() async {
    if (validateDisplayName() != null) {
      update();

      return;
    }
    if (_initialDisplayName != displayNameController.text) {
      authService.updateDisplayName(
        displayNameController.text,
        refreshUI: true,
      );
    }
    Get.back<void>();
  }

  String? validateDisplayName() {
    if (displayNameController.text.isEmpty ||
        displayNameController.text.isNumericOnly) {
      return Keys.Errors_Display_Name_Val.trans;
    }

    return null;
  }

  void toggleTheme({required bool isDarkMode}) {
    Get.changeThemeMode(isDarkMode ? ThemeMode.dark : ThemeMode.light);
    isDarkTheme = !isDarkTheme;
    update();
    Get.forceAppUpdate();
  }
}
