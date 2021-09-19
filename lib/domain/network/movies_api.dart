import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:trendy_movies/presentation/home/domain/entity/movies_page_model.dart';

part 'movies_api.g.dart';

@RestApi(baseUrl: 'https://api.themoviedb.org/3/')
abstract class MoviesApiClient {
  factory MoviesApiClient(Dio dio, {String baseUrl}) = _MoviesApiClient;

  @GET('/trending/all/day')
  Future<MoviesPageModel> getTodayTrendingMovies();
}
