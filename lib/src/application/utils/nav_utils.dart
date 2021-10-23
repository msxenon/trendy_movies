import 'package:get/get.dart';
import 'package:trendy_movies/src/application/utils/app_routes.dart';
import 'package:trendy_movies/src/domain/base_dependency_container.dart';
import 'package:trendy_movies/src/domain/entities/movie_model.dart';
import 'package:trendy_movies/src/presentation/movie_details/ui/movie_details_screen.dart';

void loadFromMainRoute() {
  if (Get.context != null) {
    Get.offAllNamed<void>(
      AppRoutes.mainRoute,
    );
  }
}

void continueAsLoggedIn() {
  if (Get.context != null) {
    if (!di.database.dbInitialized.value) {
      return loadFromMainRoute();
    }
    Get.offAllNamed<void>(AppRoutes.home);
  }
}

void openMovieDetails(Movie movie) {
  Get.to<void>(
    () => MovieDetailsScreen(
      movie: movie,
    ),
    routeName: '${AppRoutes.movieDetails}/${movie.id}',
  );
}
