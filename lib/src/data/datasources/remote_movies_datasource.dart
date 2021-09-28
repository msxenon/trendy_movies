import 'package:trendy_movies/src/data/datasources/movies_datasource.dart';
import 'package:trendy_movies/src/domain/network/movies_api.dart';
import 'package:trendy_movies/src/presentation/home/domain/entity/movie_model.dart';

class RemoteMoviesDataSource implements MoviesDataSource {
  static final MoviesApiClient _apiClient = MoviesApiClient();

  @override
  Future<List<Movie>> getMovies() async {
    final response = await _apiClient.getTodayTrendingMovies();

    return response.results;
  }
}
