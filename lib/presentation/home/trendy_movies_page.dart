import 'package:flutter/material.dart';
import 'package:flutter_swipecards/flutter_swipecards.dart';
import 'package:get/get.dart';
import 'package:terndy_movies/presentation/home/domain/entity/movie_model.dart';
import 'package:terndy_movies/presentation/home/home_controller.dart';

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
                duration: const Duration(milliseconds: 250),
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
        return const StateWidget(
          icon: Icons.local_movies_outlined,
          text: 'Seen',
          bgColor: Colors.yellow,
        );

      case MovieCardState.never:
        return const StateWidget(
          icon: Icons.close,
          text: 'Never',
          bgColor: Colors.red,
        );

      case MovieCardState.watchList:
        return const StateWidget(
          icon: Icons.favorite,
          text: 'Add to wishlist',
          bgColor: Colors.green,
        );

      case MovieCardState.maybeLater:
        return const StateWidget(
          icon: Icons.watch_later_outlined,
          text: 'Maybe later',
          bgColor: Colors.deepPurple,
        );
      case MovieCardState.defaultState:
        return const SizedBox.shrink();
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
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              Icon(
                icon,
                size: 45,
                color: Colors.white,
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                text,
                style: const TextStyle(fontSize: 30, color: Colors.white),
              ),
            ],
          ),
        )
      ],
    );
  }
}
