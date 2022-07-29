import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:student_movie_app/data/vos/cast_vo.dart';
import 'package:student_movie_app/persistence/hive_constants.dart';

part 'movie_vo.g.dart';

@JsonSerializable()
@HiveType(typeId: HIVE_TYPE_ID_MOVIE_VO, adapterName: "MovieVoAdapter")
class MovieVo {

  @JsonKey(name: "id")
  @HiveField(0)
  int id;

  @JsonKey(name: "original_title")
  @HiveField(1)
  String originalTitle;

  @JsonKey(name: "release_date")
  @HiveField(2)
  String releaseDate;

  @JsonKey(name: "genres")
  @HiveField(3)
  List<String> genres;

  @JsonKey(name: "overview")
  @HiveField(4)
  String overview;

  @JsonKey(name: "rating")
  @HiveField(5)
  double rating;

  @JsonKey(name: "runtime")
  @HiveField(6)
  int runtime;

  @JsonKey(name: "poster_path")
  @HiveField(7)
  String posterPath;

  @JsonKey(name: "casts")
  @HiveField(8)
  List<CastVo> casts;

  @HiveField(9)
  bool isNowPlaying = false;

  @HiveField(10)
  bool isComingsoon = false;

  MovieVo(
      this.id,
      this.originalTitle,
      this.releaseDate,
      this.genres,
      this.overview,
      this.rating,
      this.runtime,
      this.posterPath,
      this.casts,
      this.isNowPlaying,
      this.isComingsoon);

  factory MovieVo.fromJson(Map<String, dynamic> json) => _$MovieVoFromJson(json);

  Map<String, dynamic> toJson() => _$MovieVoToJson(this);
}