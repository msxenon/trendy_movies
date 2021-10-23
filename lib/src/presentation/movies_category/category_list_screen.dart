import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:trendy_movies/src/application/models/movie_category.dart';
import 'package:trendy_movies/src/application/utils/nav_utils.dart';
import 'package:trendy_movies/src/domain/entities/movie_model.dart';
import 'package:trendy_movies/src/presentation/home/ui/movie_card.dart';

import 'movies_category_controller.dart';

class CategoryListScreen extends GetView<MoviesCategoryController> {
  const CategoryListScreen(this.category, this.title, {Key? key})
      : super(key: key);
  final MovieCategory category;
  final String title;
  @override
  String? get tag => category.toString();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Obx(
        () {
          return Center(
            child: GridView.builder(
              itemCount: controller.items.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: Get.width ~/ 200,
              ),
              shrinkWrap: true,
              itemBuilder: (BuildContext context, int index) {
                final item = controller.items[index];

                return Card(
                  child: InkWell(
                    onTap: () => openMovieDetails(
                      Movie.fromCategorizedMovie(
                        item,
                      ),
                    ),
                    child: GridTile(
                      footer: Container(
                        padding: const EdgeInsets.all(10),
                        color: Theme.of(context)
                            .scaffoldBackgroundColor
                            .withOpacity(0.7),
                        child: Text(
                          item.name,
                          maxLines: 2,
                        ),
                      ),
                      child: Image.network(
                        MovieCard.getFullImageLink(item.posterPath),
                        fit: BoxFit.cover,
                      ), //just for testing, will fill with image later
                    ),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
