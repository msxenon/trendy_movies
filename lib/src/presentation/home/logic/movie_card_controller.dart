import 'package:get/get.dart';
import 'package:trendy_movies/src/application/models/movie_category.dart';

class MovieCardController extends GetxController {
  final Rxn<MovieCategory> state = Rxn<MovieCategory>();

  void setState(MovieCategory? newState) {
    state(newState);
  }
}
