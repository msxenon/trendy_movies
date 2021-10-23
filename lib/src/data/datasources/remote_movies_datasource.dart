import 'package:trendy_movies/src/data/datasources/movies_datasource.dart';
import 'package:trendy_movies/src/domain/entities/movie_model.dart';
import 'package:trendy_movies/src/domain/network/movies_api.dart';

class RemoteMoviesDataSource implements MoviesDataSource {
  static final MoviesApiClient _apiClient = MoviesApiClient();

  @override
  Future<List<Movie>> getMoviesFromDataSource() async {
    final response = await _apiClient.getTodayTrendingMovies();

    return response.results;
  }
}
