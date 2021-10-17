import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:trendy_movies/src/application/models/movie_category.dart';
import 'package:trendy_movies/src/presentation/movies_category/category_list_screen.dart';
import 'package:trendy_movies/src/presentation/movies_category/movies_category_controller.dart';

class DrawerTile extends GetWidget<MoviesCategoryController> {
  final String title;
  final MovieCategory category;
  @override
  String? get tag => category.toString();
  const DrawerTile(
    this.title,
    this.category, {
    Key? key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final icon = _categoryToIcon();

    return ListTile(
      leading: Icon(
        icon,
      ),
      title: Text(title),
      trailing: Obx(
        () => Text(
          controller.items.length.toString(),
        ),
      ),
      onTap: () {
        Get.to<void>(
          () => CategoryListScreen(
            category,
            title,
          ),
        );
      },
    );
  }

  IconData _categoryToIcon() {
    switch (category) {
      case MovieCategory.watchLater:
        return Icons.watch_later;

      case MovieCategory.wishList:
        return Icons.favorite;

      case MovieCategory.seen:
        return Icons.remove_red_eye_rounded;

      case MovieCategory.never:
        return Icons.close;
    }
  }
}
