import 'package:get/get.dart';
import 'package:trendy_movies/src/domain/providers/movies_provider.dart';
import 'package:trendy_movies/src/domain/repo/movies_repo.dart';
import 'package:trendy_movies/src/presentation/home/domain/entity/movie_model.dart';

class MoviesRepoImpl implements MoviesRepo {
  @override
  Future<List<Movie>> getMoviesFromRepo() async {
    final moviesList = await provider.getMoviesFromProviders();
    final finalList = moviesList.where((element) => element.isValid).toList();
    return finalList;
  }

  @override
  MoviesProvider get provider => Get.find();
}
