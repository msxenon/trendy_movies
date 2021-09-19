import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_loggy_dio/flutter_loggy_dio.dart';
import 'package:trendy_movies/domain/network/movies_api.dart';
import 'package:trendy_movies/presentation/home/domain/entity/movie_model.dart';

class CustomHttpClient {
  CustomHttpClient() {
    dio.interceptors.add(LoggyDioInterceptor());
    dio.options.headers
        .putIfAbsent('api_key', () => dotenv.env['THE_MOVIEDB_API_KEY']);
  }
  final dio = Dio();
}

abstract class MoviesRepo {
  MoviesRepo(this.client);
  final CustomHttpClient client;
  late final _moviesApiClient = MoviesApiClient(client.dio);
  @protected
  Future<List<Movie>> getMoviesFromApi() async {
    final moviesPage = await _moviesApiClient.getTodayTrendingMovies();

    return moviesPage.results;
  }

  @protected
  Future<List<Movie>> getMoviesDB();
}
