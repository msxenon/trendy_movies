// class CustomHttpClient {
//   CustomHttpClient() {
//     dio.interceptors.add(LoggyDioInterceptor());
//     dio.options.headers
//         .putIfAbsent('api_key', () => EnvironmentConfig.theMovieDbApiKey);
//   }
//   final dio = Dio();
// }

// abstract class MoviesRepo {
//   MoviesRepo(this.client);
//   final CustomHttpClient client;
//   late final _moviesApiClient = MoviesApiClient(client.dio);
//   @protected
//   Future<List<Movie>> getMoviesFromApi() async {
//     final moviesPage = await _moviesApiClient.getTodayTrendingMovies();
//
//     return moviesPage.results;
//   }
//
//   @protected
//   Future<List<Movie>> getMoviesDB();
// }
