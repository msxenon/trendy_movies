import 'package:get/get.dart';
import 'package:trendy_movies/src/data/datasources/local_movies_datasource.dart';
import 'package:trendy_movies/src/data/datasources/movies_datasource.dart';
import 'package:trendy_movies/src/data/datasources/remote_movies_datasource.dart';
import 'package:trendy_movies/src/domain/providers/movies_provider.dart';
import 'package:trendy_movies/src/presentation/home/domain/entity/movie_model.dart';

class MoviesProviderImpl implements MoviesProvider {
  @override
  Future<List<Movie>> getMovies() async {
    return remoteDataSource
        .getMovies()
        .onError((error, stackTrace) => localDataSource.getMovies());
  }

  @override
  MoviesDataSource get localDataSource => Get.find<LocalMoviesDataSource>();

  @override
  MoviesDataSource get remoteDataSource => Get.find<RemoteMoviesDataSource>();
}
