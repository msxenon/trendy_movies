import 'package:flutter/material.dart';
import 'package:flutter_swipecards/flutter_swipecards.dart';
import 'package:get/get.dart';
import 'package:trendy_movies/src/domain/base_dependency_container.dart';
import 'package:trendy_movies/src/domain/repo/movies_repo.dart';
import 'package:trendy_movies/src/presentation/home/domain/entity/movie_model.dart';
import 'package:trendy_movies/src/presentation/home/logic/movie_card_controller.dart';

class HomeController extends GetxController
    with StateMixin<List<Movie>>, BaseToolBox {
  HomeController();
  final RxInt index = 0.obs;
  MoviesRepo get moviesRepo => Get.find();
  @override
  void onInit() {
    super.onInit();

    //Loading, Success, Error handle with 1 line of code
    append(() => moviesRepo.getMovies);
  }

  void setCurrentIndex(CardSwipeOrientation orientation, int _index) {
    index.value = _index;
    if (orientation == CardSwipeOrientation.recover) {
      backToDefault();
    }
  }

  void cardDrag(DragUpdateDetails details, Alignment align) {
    final x = align.x;
    final y = align.y;
    final xAbs = x.abs();
    final yAbs = y.abs();
    // print('$xAbs == $yAbs');

    if (xAbs + yAbs < 1) {
      backToDefault();

      return;
    }
    if (xAbs > yAbs) {
      if (x < 0) {
        //Card is LEFT swiping
        updateStackLeft();
      } else if (x > 0) {
        //Card is RIGHT swiping
        updateStackRight();
      }
    } else {
      if (y < 0) {
        //Card is UP swiping
        updateStackUp();
      } else if (y > 0) {
        //Card is DOWN swiping
        updateStackDown();
      }
    }
  }

  void updateStackLeft() {
    getCurrentMovieCard()?.setState(MovieCardState.maybeLater);
  }

  void updateStackRight() {
    getCurrentMovieCard()?.setState(MovieCardState.watchList);
  }

  void updateStackDown() {
    getCurrentMovieCard()?.setState(MovieCardState.never);
  }

  void updateStackUp() {
    getCurrentMovieCard()?.setState(MovieCardState.seen);
  }

  void backToDefault() {
    getCurrentMovieCard()?.setState(MovieCardState.defaultState);
  }

  MovieCardController? getCurrentMovieCard() {
    try {
      return Get.find<MovieCardController>(
        tag: state![index.value].id.toString(),
      );
    } catch (e, s) {
      logger.error(e, s);

      return null;
    }
  }
}
