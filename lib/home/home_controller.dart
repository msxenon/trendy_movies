import 'package:flutter/material.dart';
import 'package:flutter_swipecards/flutter_swipecards.dart';
import 'package:get/get.dart';
import 'package:terndy_movies/home/trendy_movies_page.dart';
import 'package:terndy_movies/movies/movies_service.dart';

import 'domain/entity/movies_page_model.dart';

class HomeController extends GetxController with StateMixin<MoviesPageModel> {
  HomeController({required this.homeRepository});
  final RxInt index = 0.obs;
  final IHomeRepository homeRepository;
  @override
  void onInit() {
    super.onInit();

    //Loading, Success, Error handle with 1 line of code
    append(() => homeRepository.getCases);
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
          tag: state!.results[index.value].id.toString());
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}
