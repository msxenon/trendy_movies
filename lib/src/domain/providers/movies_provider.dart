import 'package:trendy_movies/src/data/datasources/movies_datasource.dart';
import 'package:trendy_movies/src/domain/entities/movie_model.dart';

abstract class MoviesProvider {
  MoviesProvider({
    required this.localDataSource,
    required this.remoteDataSource,
  });

  final MoviesDataSource localDataSource;
  final MoviesDataSource remoteDataSource;

  Future<List<Movie>> getMoviesFromProviders();
}
