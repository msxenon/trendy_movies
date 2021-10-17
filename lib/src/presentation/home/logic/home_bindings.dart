import 'package:get/get.dart';
import 'package:trendy_movies/src/application/models/movie_category.dart';
import 'package:trendy_movies/src/data/datasources/local_movies_datasource.dart';
import 'package:trendy_movies/src/data/datasources/remote_movies_datasource.dart';
import 'package:trendy_movies/src/data/providers/movies_provider_impl.dart';
import 'package:trendy_movies/src/data/repo/movies_repo_impl.dart';
import 'package:trendy_movies/src/domain/providers/movies_provider.dart';
import 'package:trendy_movies/src/domain/repo/movies_repo.dart';
import 'package:trendy_movies/src/presentation/home/logic/home_controller.dart';
import 'package:trendy_movies/src/presentation/movies_category/movies_category_controller.dart';

class HomeScreenBindings extends Bindings {
  @override
  void dependencies() {
    Get
      ..lazyPut<LocalMoviesDataSource>(
        () => LocalMoviesDataSource(),
      )
      ..put(
        MoviesCategoryController(MovieCategory.wishList),
        tag: MovieCategory.wishList.toString(),
      )
      ..put(
        MoviesCategoryController(MovieCategory.watchLater),
        tag: MovieCategory.watchLater.toString(),
      )
      ..put(
        MoviesCategoryController(MovieCategory.seen),
        tag: MovieCategory.seen.toString(),
      )
      ..put<RemoteMoviesDataSource>(RemoteMoviesDataSource())
      ..put<MoviesProvider>(MoviesProviderImpl())
      ..put<MoviesRepo>(MoviesRepoImpl())
      ..put(
        HomeController(),
      );
  }
}
