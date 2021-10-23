import 'package:trendy_movies/src/domain/entities/movie_model.dart';
import 'package:trendy_movies/src/domain/providers/movies_provider.dart';

abstract class MoviesRepo {
  final MoviesProvider provider;

  MoviesRepo(this.provider);
  Future<List<Movie>> getMoviesFromRepo();
}
