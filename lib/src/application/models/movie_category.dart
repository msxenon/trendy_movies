import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:trendy_movies/src/application/services/database/hive_adapters_ids.dart';

part 'movie_category.g.dart';

@HiveType(typeId: HiveAdaptersData.movieCategoryModelTid)
enum MovieCategory {
  @JsonValue('watchLater')
  @HiveField(0)
  watchLater,
  @JsonValue('wishList')
  @HiveField(1)
  wishList,
  @JsonValue('seen')
  @HiveField(2)
  seen,
  @JsonValue('never')
  @HiveField(3)
  never,
}
