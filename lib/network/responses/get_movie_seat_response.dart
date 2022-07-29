
import 'package:json_annotation/json_annotation.dart';
import 'package:student_movie_app/data/vos/movie_seat_vo.dart';

part 'get_movie_seat_response.g.dart';

@JsonSerializable()
class GetMovieSeatsResponse {

  @JsonKey(name: "code")
  int code;

  @JsonKey(name: "message")
  String message;

  @JsonKey(name: "data")
  List<List<MovieSeatVO>> data;

  GetMovieSeatsResponse(this.code, this.message, this.data);

  factory GetMovieSeatsResponse.fromJson(Map<String, dynamic> json) => _$GetMovieSeatsResponseFromJson(json);

  Map<String, dynamic> toJson() => _$GetMovieSeatsResponseToJson(this);
}