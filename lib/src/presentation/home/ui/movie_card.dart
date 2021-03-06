import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:trendy_movies/src/application/utils/nav_utils.dart';
import 'package:trendy_movies/src/domain/entities/movie_model.dart';
import 'package:trendy_movies/src/presentation/home/logic/movie_card_controller.dart';
import 'package:trendy_movies/src/presentation/home/ui/movie_card_state_widget.dart';

class MovieCard extends GetView<MovieCardController> {
  MovieCard({
    Key? key,
    required this.item,
  })  : _controller = Get.put(
          MovieCardController(),
          tag: item.id!.toString(),
        ),
        super(key: key);
  static String getFullImageLink(String? path) {
    return 'https://image.tmdb.org/t/p/original/$path';
  }

  final Movie item;
  final MovieCardController _controller;
  @override
  MovieCardController get controller => _controller;
  @override
  String? get tag => item.id!.toString();
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Card(
        elevation: 5,
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          onTap: () => openMovieDetails(item),
          child: Stack(
            children: [
              Container(
                width: Get.width,
                height: Get.width * 2,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: NetworkImage(
                      getFullImageLink(item.posterPath),
                    ),
                  ),
                ),
              ),
              AnimatedSwitcher(
                duration: const Duration(milliseconds: 250),
                child: MovieCardStateWidget(
                  state: controller.state.value,
                  key: Key(
                    controller.state.value.toString(),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
