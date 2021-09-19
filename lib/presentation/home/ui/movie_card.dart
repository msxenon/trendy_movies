import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:trendy_movies/presentation/home/domain/entity/movie_model.dart';
import 'package:trendy_movies/presentation/home/logic/movie_card_controller.dart';
import 'package:trendy_movies/presentation/home/ui/movie_card_state_widget.dart';

class MovieCard extends StatelessWidget {
  MovieCard({
    Key? key,
    required this.item,
  }) : super(key: key);

  final Movie item;
  late final MovieCardController _controller = Get.put(
    MovieCardController(),
    tag: item.id!.toString(),
  );
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Card(
        elevation: 5,
        clipBehavior: Clip.antiAlias,
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
                    'https://image.tmdb.org/t/p/original/${item.backdropPath}',
                  ),
                ),
              ),
            ),
            AnimatedSwitcher(
              duration: const Duration(milliseconds: 250),
              child: MovieCardStateWidget(
                state: _controller.state.value,
                key: Key(
                  _controller.state.value.toString(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
