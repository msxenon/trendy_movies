import 'package:trendy_movies/src/data/datasources/movies_datasource.dart';
import 'package:trendy_movies/src/presentation/home/domain/entity/movie_model.dart';

class LocalMoviesDataSource implements MoviesDataSource {
  @override
  Future<List<Movie>> getMovies() async {
    return [];
  }
}
