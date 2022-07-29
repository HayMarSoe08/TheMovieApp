import 'package:json_annotation/json_annotation.dart';
import 'package:student_movie_app/data/vos/movie_vo.dart';

part 'get_movie_detail_response.g.dart';

@JsonSerializable()
class GetMovieDetailResponse {
  @JsonKey(name: "code")
  int code;

  @JsonKey(name: "message")
  String message;

  @JsonKey(name: "data")
  MovieVo data;

  GetMovieDetailResponse(this.code, this.message, this.data);

  factory GetMovieDetailResponse.fromJson(Map<String, dynamic> json) => _$GetMovieDetailResponseFromJson(json);

  Map<String, dynamic> toJson() => _$GetMovieDetailResponseToJson(this);
}