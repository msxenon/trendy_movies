import 'package:flutter/material.dart';
import 'package:flutter_swipecards/flutter_swipecards.dart';
import 'package:get/get.dart';
import 'package:terndy_movies/presentation/home/logic/home_controller.dart';
import 'package:terndy_movies/presentation/home/ui/movie_card.dart';

class TrendyMoviesPage extends GetView<HomeController> {
  const TrendyMoviesPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return controller.obx((state) {
      return Center(
        child: SizedBox(
          height: MediaQuery.of(context).size.height * 0.6,
          child: TinderSwapCard(
            swipeUp: true,
            swipeDown: true,
            totalNum: state!.results.length,
            swipeEdge: 4,
            maxWidth: MediaQuery.of(context).size.width * 0.9,
            maxHeight: MediaQuery.of(context).size.width * 0.9,
            minWidth: MediaQuery.of(context).size.width * 0.8,
            minHeight: MediaQuery.of(context).size.width * 0.8,
            cardBuilder: (context, index) => MovieCard(
              item: state.results[index],
            ),
            swipeUpdateCallback: controller.cardDrag,
            swipeCompleteCallback: controller.setCurrentIndex,
          ),
        ),
      );
    });
  }
}
