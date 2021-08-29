import 'package:flutter/material.dart';
import 'package:flutter_swipecards/flutter_swipecards.dart';
import 'package:get/get.dart';
import 'package:terndy_movies/home/domain/entity/movie_model.dart';

import 'home_controller.dart';

class TrendyMoviesPage extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    return controller.obx((state) {
      return Center(
        child: Container(
          height: MediaQuery.of(context).size.height * 0.6,
          child: TinderSwapCard(
              swipeUp: true,
              swipeDown: true,
              orientation: AmassOrientation.bottom,
              totalNum: state!.results.length,
              stackNum: 3,
              swipeEdge: 4.0,
              maxWidth: MediaQuery.of(context).size.width * 0.9,
              maxHeight: MediaQuery.of(context).size.width * 0.9,
              minWidth: MediaQuery.of(context).size.width * 0.8,
              minHeight: MediaQuery.of(context).size.width * 0.8,
              cardBuilder: (context, index) =>
                  MovieCard(item: state.results[index]),
              swipeUpdateCallback: controller.cardDrag,
              swipeCompleteCallback: controller.setCurrentIndex),
        ),
      );
    });
  }
}

enum MovieCardState { watchList, never, maybeLater, seen, defaultState }

class MovieCardController extends GetxController {
  final Rx<MovieCardState> state = MovieCardState.defaultState.obs;

  void setState(MovieCardState newState) {
    state(newState);
  }
}

class MovieCard extends StatelessWidget {
  MovieCard({
    Key? key,
    required this.item,
  }) : super(key: key);

  final Movie item;
  late final MovieCardController _controller =
      Get.put(MovieCardController(), tag: item.id!.toString());
  @override
  Widget build(BuildContext context) {
    return Obx(() => Card(
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
                            'https://image.tmdb.org/t/p/original/${item.backdropPath}'))),
              ),
              AnimatedSwitcher(
                duration: Duration(milliseconds: 250),
                child: MovieCardStateWidget(
                  state: _controller.state.value,
                  key: Key(_controller.state.value.toString()),
                ),
              )
            ],
          ),
        ));
  }
}

class MovieCardStateWidget extends StatelessWidget {
  const MovieCardStateWidget({required this.state, Key? key}) : super(key: key);
  final MovieCardState state;
  @override
  Widget build(BuildContext context) {
    switch (state) {
      case MovieCardState.seen:
        return StateWidget(
          icon: Icons.local_movies_outlined,
          text: 'Seen',
          bgColor: Colors.yellow,
        );

      case MovieCardState.never:
        return StateWidget(
          icon: Icons.close,
          text: 'Never',
          bgColor: Colors.red,
        );

      case MovieCardState.watchList:
        return StateWidget(
          icon: Icons.favorite,
          text: 'Add to wishlist',
          bgColor: Colors.green,
        );

      case MovieCardState.maybeLater:
        return StateWidget(
          icon: Icons.watch_later_outlined,
          text: 'Maybe later',
          bgColor: Colors.deepPurple,
        );
      case MovieCardState.defaultState:
        return SizedBox.shrink();
    }
  }
}

class StateWidget extends StatelessWidget {
  const StateWidget({
    required this.icon,
    required this.text,
    required this.bgColor,
    Key? key,
  }) : super(key: key);
  final IconData icon;
  final String text;
  final Color bgColor;
  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.topCenter,
      children: [
        Container(
          color: bgColor.withOpacity(.5),
        ),
        Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            children: [
              Icon(
                icon,
                size: 45,
                color: Colors.white,
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                text,
                style: TextStyle(fontSize: 30, color: Colors.white),
              ),
            ],
          ),
        )
      ],
    );
  }
}
