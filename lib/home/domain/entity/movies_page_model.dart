import 'package:freezed_annotation/freezed_annotation.dart';

import 'movie_model.dart';

part 'movies_page_model.freezed.dart';
part 'movies_page_model.g.dart';

@freezed
class MoviesPageModel with _$MoviesPageModel {
  const factory MoviesPageModel({
    required int page,
    required List<Movie> results,
    @JsonKey(name: 'total_pages') required int totalPages,
    @JsonKey(name: 'total_results') required int totalResults,
  }) = Data;

  factory MoviesPageModel.fromJson(
    Map<String, dynamic> json,
  ) =>
      _$MoviesPageModelFromJson(json);
}
