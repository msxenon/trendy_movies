import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_swipecards/flutter_swipecards.dart';
import 'package:get/get.dart';
import 'package:trendy_movies/src/application/localisation/keys.dart';
import 'package:trendy_movies/src/presentation/home/logic/home_controller.dart';
import 'package:trendy_movies/src/presentation/home/ui/movie_card.dart';

class TrendyMoviesPage extends GetResponsiveView<HomeController> {
  TrendyMoviesPage({Key? key})
      : super(
          alwaysUseBuilder: true,
          key: key,
        );

  @override
  Widget? phone() {
    return SizedBox(
      height: MediaQuery.of(Get.context!).size.height * 0.6,
      child: TinderSwapCard(
        swipeUp: true,
        swipeDown: true,
        totalNum: controller.state!.length,
        swipeEdge: 4,
        maxWidth: MediaQuery.of(Get.context!).size.width * 0.9,
        maxHeight: MediaQuery.of(Get.context!).size.width * 0.9,
        minWidth: MediaQuery.of(Get.context!).size.width * 0.8,
        minHeight: MediaQuery.of(Get.context!).size.width * 0.8,
        cardBuilder: (context, index) {
          final movie = controller.state![index];

          return MovieCard(
            key: Key(
              movie.id!.toString(),
            ),
            item: movie,
          );
        },
        swipeUpdateCallback: controller.cardDrag,
        swipeCompleteCallback: controller.setCurrentIndex,
      ),
    );
  }

  @override
  Widget? desktop() {
    final size = MediaQuery.of(Get.context!).size;
    final minMaxSpace = min(size.height, size.width);

    return TinderSwapCard(
      swipeUp: true,
      swipeDown: true,
      totalNum: controller.state!.length,
      swipeEdge: 4,
      maxWidth: minMaxSpace,
      maxHeight: minMaxSpace,
      minWidth: 100,
      minHeight: 100,
      cardBuilder: (context, index) {
        final movie = controller.state![index];

        return MovieCard(
          key: Key(
            movie.id!.toString(),
          ),
          item: movie,
        );
      },
      swipeUpdateCallback: controller.cardDrag,
      swipeCompleteCallback: controller.setCurrentIndex,
    );
  }

  @override
  Widget? builder() {
    return controller.obx(
      (state) {
        return Center(
          child: screen.isPhone ? phone()! : desktop()!,
        );
      },
      onEmpty: Center(
        child: Text(
          Keys.Labels_Empty_Check_Home.trans,
        ),
      ),
    );
  }
}
