import 'package:trendy_movies/src/application/models/categorized_movie.dart';
import 'package:trendy_movies/src/application/models/movie_category.dart';
import 'package:trendy_movies/src/application/services/database/hive_adapters_ids.dart';
import 'package:trendy_movies/src/application/services/database/layers/dblayer_base.dart';

class CategorizedMoviesDBLayer extends DBLayer<CategorizedMovie> {
  @override
  String get boxName => HiveAdaptersData.categorizedMovieModelAdapterName;

  @override
  bool get deleteOnError => true;

  @override
  void registerLayerAdapters() {
    registerAdapter(() => MovieCategoryAdapter());
    registerAdapter(() => CategorizedMovieAdapter());
  }
}
