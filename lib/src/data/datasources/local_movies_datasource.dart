import 'package:trendy_movies/src/data/datasources/movies_datasource.dart';
import 'package:trendy_movies/src/domain/entities/movie_model.dart';

class LocalMoviesDataSource implements MoviesDataSource {
  @override
  Future<List<Movie>> getMoviesFromDataSource() async {
    return [];
  }
}
