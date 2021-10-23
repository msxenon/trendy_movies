// ignore_for_file: invalid_annotation_target

import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hive/hive.dart';
import 'package:trendy_movies/src/application/models/movie_category.dart';
import 'package:trendy_movies/src/application/services/database/hive_adapters_ids.dart';
import 'package:trendy_movies/src/domain/entities/movie_model.dart';

part 'categorized_movie.freezed.dart';
part 'categorized_movie.g.dart';

@freezed
class CategorizedMovie with _$CategorizedMovie {
  @HiveType(
    typeId: HiveAdaptersData.categorizedMovieModelTid,
    adapterName: HiveAdaptersData.categorizedMovieModelAdapterName,
  )
  const factory CategorizedMovie({
    @HiveField(0) required int id,
    @HiveField(1) required MovieCategory category,
    @HiveField(2) required String name,
    @HiveField(10) String? overview,
    @HiveField(12) @JsonKey(name: 'poster_path') String? posterPath,
    @HiveField(13) @JsonKey(name: 'release_date') String? releaseDate,
    @HiveField(15) @JsonKey(name: 'vote_average') double? voteAverage,
  }) = Data;

  factory CategorizedMovie.fromJson(Map<String, dynamic> json) =>
      _$CategorizedMovieFromJson(json);

  factory CategorizedMovie.fromMovie(Movie movie, MovieCategory category) {
    return CategorizedMovie.fromJson(
      movie.toJson()
        ..putIfAbsent(
          'category',
          () => describeEnum(category),
        ),
    );
  }
}
