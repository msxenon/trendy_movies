import 'package:trendy_movies/src/application/services/database/hive_database_service.dart';
import 'package:trendy_movies/src/application/services/database/layers/categorized_movies/categorized_movies_mixin.dart';

class DatabaseServiceImpl extends AppDatabaseService
    with CategorizedMoviesMixin {}
