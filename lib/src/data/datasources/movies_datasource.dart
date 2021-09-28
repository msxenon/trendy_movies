import 'package:trendy_movies/src/presentation/home/domain/entity/movie_model.dart';

abstract class MoviesDataSource {
  Future<List<Movie>> getMovies();
}
