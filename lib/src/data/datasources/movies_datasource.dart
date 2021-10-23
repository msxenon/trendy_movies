import 'package:trendy_movies/src/domain/entities/movie_model.dart';

abstract class MoviesDataSource {
  Future<List<Movie>> getMoviesFromDataSource();
}
