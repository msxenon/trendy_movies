import 'package:trendy_movies/src/domain/providers/movies_provider.dart';
import 'package:trendy_movies/src/presentation/home/domain/entity/movie_model.dart';

abstract class MoviesRepo {
  final MoviesProvider provider;

  MoviesRepo(this.provider);
  Future<List<Movie>> getMovies() async {
    final moviesList = await provider.getMovies();

    return moviesList.where((element) => element.isValid).toList();
  }
}
