import 'package:trendy_movies/src/application/models/categorized_movie.dart';
import 'package:trendy_movies/src/application/models/movie_category.dart';
import 'package:trendy_movies/src/application/services/database/hive_database_service.dart';
import 'package:trendy_movies/src/application/services/database/layers/categorized_movies/categorized_movies_layer.dart';
import 'package:trendy_movies/src/presentation/home/domain/entity/movie_model.dart';

mixin CategorizedMoviesMixin on AppDatabaseService {
  final categorizedMoviesDBLayer = CategorizedMoviesDBLayer();
  @override
  void onAddDBLayer() {
    dbLayers.add(categorizedMoviesDBLayer);
    super.onAddDBLayer();
  }

  void put({
    required Movie movie,
    required MovieCategory category,
  }) {
    final categorizedMovie = CategorizedMovie.fromMovie(movie, category);
    categorizedMoviesDBLayer.box.put(
      categorizedMovie.id,
      categorizedMovie,
    );
  }
}
