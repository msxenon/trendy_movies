import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:trendy_movies/src/domain/entities/movies_page_model.dart';
import 'package:trendy_movies/src/domain/network/movies_http_client.dart';

part 'movies_api.g.dart';

@RestApi(baseUrl: 'https://api.themoviedb.org/3/')
abstract class MoviesApiClient {
  static final _client = CustomHttpClient();

  factory MoviesApiClient() => _MoviesApiClient(_client.dio);

  @GET('/trending/all/day')
  Future<MoviesPageModel> getTodayTrendingMovies();
}
