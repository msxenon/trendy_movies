import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:trendy_movies/src/domain/entities/movie_model.dart';
import 'package:trendy_movies/src/presentation/home/logic/home_controller.dart';
import 'package:trendy_movies/src/presentation/home/ui/movie_card.dart';

class MovieDetailsScreen extends GetResponsiveView<HomeController> {
  MovieDetailsScreen({
    required this.movie,
    Key? key,
  }) : super(key: key);
  final Movie movie;

  @override
  bool get alwaysUseBuilder => true;

  @override
  Widget? desktop() {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          movie.name!,
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Image.network(
              MovieCard.getFullImageLink(movie.posterPath),
              height: Get.height / 2,
              width: Get.width,
              fit: BoxFit.cover,
            ),
            Padding(
              padding: const EdgeInsets.all(
                20,
              ),
              child: Center(
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (movie.voteAverage != null)
                      Text(
                        'Rate:\n${movie.voteAverage.toString()}',
                      ),
                    if (movie.releaseDate != null)
                      Text(
                        'Released:\n${movie.releaseDate.toString()}',
                      ),
                  ],
                ),
              ),
            ),
            if (movie.overview != null)
              Padding(
                padding: const EdgeInsets.all(
                  20,
                ),
                child: Text(
                  'Overview:\n${movie.overview!}',
                ),
              ),
          ],
        ),
      ),
    );
  }
}
