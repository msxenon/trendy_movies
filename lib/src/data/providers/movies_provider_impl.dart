import 'package:get/get.dart';
import 'package:trendy_movies/src/data/datasources/local_movies_datasource.dart';
import 'package:trendy_movies/src/data/datasources/movies_datasource.dart';
import 'package:trendy_movies/src/data/datasources/remote_movies_datasource.dart';
import 'package:trendy_movies/src/domain/entities/movie_model.dart';
import 'package:trendy_movies/src/domain/providers/movies_provider.dart';

class MoviesProviderImpl implements MoviesProvider {
  @override
  Future<List<Movie>> getMoviesFromProviders() async {
    return remoteDataSource.getMoviesFromDataSource().onError(
          (error, stackTrace) => localDataSource.getMoviesFromDataSource(),
        );
  }

  @override
  MoviesDataSource get localDataSource => Get.find<LocalMoviesDataSource>();

  @override
  MoviesDataSource get remoteDataSource => Get.find<RemoteMoviesDataSource>();
}
