import 'package:flutter/material.dart';
import 'package:flutter_swipecards/flutter_swipecards.dart';
import 'package:get/get.dart';
import 'package:trendy_movies/src/application/models/movie_category.dart';
import 'package:trendy_movies/src/domain/base_dependency_container.dart';
import 'package:trendy_movies/src/domain/repo/movies_repo.dart';
import 'package:trendy_movies/src/presentation/home/domain/entity/movie_model.dart';
import 'package:trendy_movies/src/presentation/home/logic/movie_card_controller.dart';

class HomeController extends GetxController
    with StateMixin<List<Movie>>, BaseToolBox {
  final RxInt index = 0.obs;
  MoviesRepo get moviesRepo => Get.find();
  List<int> getSkippedMoviesIds() {
    return database.categorizedMoviesDBLayer.box.values
        .map((e) => e.id)
        .toList();
  }

  @override
  void onInit() {
    super.onInit();
    //Loading, Success, Error handle with 1 line of code
    append(() => moviesRepo.getMoviesFromRepo);
  }

  @override
  void change(List<Movie>? newState, {RxStatus? status}) {
    if (newState != null && status?.isSuccess == true) {
      final skippedIds = getSkippedMoviesIds();
      final List<Movie> newCalculatedState = newState
          .where(
            (element) => !skippedIds.contains(element.id),
          )
          .toList();

      super.change(newCalculatedState,
          status: newCalculatedState.isEmpty ? RxStatus.empty() : status);
      return;
    }

    super.change(newState, status: status);
  }

  void setCurrentIndex(CardSwipeOrientation orientation, int _index) {
    index.value = _index;
    if (orientation == CardSwipeOrientation.recover) {
      backToDefault();
    } else {
      _saveCategorizedMovie(_index);
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
    getCurrentMovieCard()?.setState(MovieCategory.watchLater);
  }

  void updateStackRight() {
    getCurrentMovieCard()?.setState(MovieCategory.wishList);
  }

  void updateStackDown() {
    getCurrentMovieCard()?.setState(MovieCategory.never);
  }

  void updateStackUp() {
    getCurrentMovieCard()?.setState(MovieCategory.seen);
  }

  void backToDefault() {
    getCurrentMovieCard()?.setState(null);
  }

  MovieCardController? getCurrentMovieCard([int? customIndex]) {
    try {
      final _index = customIndex ?? index.value;

      return Get.find<MovieCardController>(
        tag: state![_index].id.toString(),
      );
    } catch (e, s) {
      logger.error(error: e, stackTrace: s);

      return null;
    }
  }

  Future<void> _saveCategorizedMovie(int index) async {
    try {
      final movie = state![index];

      await database.putCategorizedMovie(
        movie: movie,
        category: getCurrentMovieCard(index)!.state.value!,
      );
    } catch (e, s) {
      logger.error(
        error: e,
        stackTrace: s,
      );
    }
  }
}
