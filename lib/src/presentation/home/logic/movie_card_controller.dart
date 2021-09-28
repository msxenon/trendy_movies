import 'package:get/get.dart';

enum MovieCardState { watchList, never, maybeLater, seen, defaultState }

class MovieCardController extends GetxController {
  final Rx<MovieCardState> state = MovieCardState.defaultState.obs;

  void setState(MovieCardState newState) {
    state(newState);
  }
}
