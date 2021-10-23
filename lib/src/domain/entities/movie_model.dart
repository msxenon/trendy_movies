// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:trendy_movies/src/application/models/categorized_movie.dart';

part 'movie_model.freezed.dart';
part 'movie_model.g.dart';

@freezed
class Movie with _$Movie {
  const factory Movie({
    int? id,
    String? name,
    String? overview,
    @JsonKey(name: 'poster_path') String? posterPath,
    @JsonKey(name: 'release_date') String? releaseDate,
    @JsonKey(name: 'vote_average') double? voteAverage,
  }) = Data;

  factory Movie.fromJson(Map<String, dynamic> json) => _$MovieFromJson(json);
  factory Movie.fromCategorizedMovie(
    CategorizedMovie categorizedMovie,
  ) {
    return Movie.fromJson(
      categorizedMovie.toJson(),
    );
  }
}

extension MovieExts on Movie {
  bool get isValid => id != null && name != null && posterPath != null;
}
