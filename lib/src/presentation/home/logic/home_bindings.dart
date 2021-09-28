import 'package:get/get.dart';
import 'package:trendy_movies/src/data/datasources/local_movies_datasource.dart';
import 'package:trendy_movies/src/data/datasources/remote_movies_datasource.dart';
import 'package:trendy_movies/src/data/providers/movies_provider_impl.dart';
import 'package:trendy_movies/src/data/repo/movies_repo_impl.dart';
import 'package:trendy_movies/src/domain/providers/movies_provider.dart';
import 'package:trendy_movies/src/domain/repo/movies_repo.dart';
import 'package:trendy_movies/src/presentation/home/logic/home_controller.dart';

class HomeScreenBindings extends Bindings {
  @override
  void dependencies() {
    Get
      ..lazyPut<LocalMoviesDataSource>(
        () => LocalMoviesDataSource(),
      )
      ..put<RemoteMoviesDataSource>(RemoteMoviesDataSource())
      ..put<MoviesProvider>(MoviesProviderImpl())
      ..put<MoviesRepo>(MoviesRepoImpl())
      ..put(
        HomeController(),
      );
  }
}
