// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';

part 'movie_model.freezed.dart';
part 'movie_model.g.dart';

@freezed
class Movie with _$Movie {
  const factory Movie({
    int? id,
    String? name,
    bool? adult,
    @JsonKey(name: 'backdrop_path') String? backdropPath,
    @JsonKey(name: 'first_air_date') String? firstAirDate,
    @JsonKey(name: 'original_language') String? originalLanguage,
    @JsonKey(name: 'original_name') String? originalName,
    @JsonKey(name: 'original_title') String? originalTitle,
    String? overview,
    double? popularity,
    @JsonKey(name: 'poster_path') String? posterPath,
    @JsonKey(name: 'release_date') String? releaseDate,
    String? title,
    bool? video,
    @JsonKey(name: 'vote_average') double? voteAverage,
    @JsonKey(name: 'vote_count') int? voteCount,
    @JsonKey(name: 'origin_country') List<String>? originCountry,
    @JsonKey(name: 'genre_ids') List<int>? genreIds,
  }) = Data;

  factory Movie.fromJson(Map<String, dynamic> json) => _$MovieFromJson(json);
}

extension MovieExts on Movie {
  bool get isValid =>
      id != null && title != null && posterPath != null && backdropPath != null;
}
