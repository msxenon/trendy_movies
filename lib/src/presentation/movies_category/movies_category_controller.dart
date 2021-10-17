import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:trendy_movies/src/application/models/categorized_movie.dart';
import 'package:trendy_movies/src/application/models/movie_category.dart';
import 'package:trendy_movies/src/application/utils/stream_listener.dart';
import 'package:trendy_movies/src/domain/base_dependency_container.dart';

class MoviesCategoryController extends GetxController
    with StreamListener<CategorizedMovie> {
  MoviesCategoryController(this.category);

  final MovieCategory category;

  @override
  List<Box<CategorizedMovie>?> boxesToListenTo() {
    return [di.database.categorizedMoviesDBLayer.box];
  }

  @override
  List<CategorizedMovie> streamFilter(List<CategorizedMovie> event) {
    return event.where((element) => element.category == category).toList();
  }
}
