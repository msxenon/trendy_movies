import 'package:flutter/cupertino.dart';
import 'package:terndy_movies/domain/base_service.dart';
import 'package:terndy_movies/domain/network/custom_http_client.dart';
import 'package:terndy_movies/domain/network/movies_api.dart';
import 'package:terndy_movies/presentation/home/domain/entity/movie_model.dart';

abstract class MoviesRepo extends BaseService {
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
