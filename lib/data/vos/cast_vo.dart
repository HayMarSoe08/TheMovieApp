
import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:student_movie_app/persistence/hive_constants.dart';

part 'cast_vo.g.dart';

@JsonSerializable()
@HiveType(typeId: HIVE_TYPE_ID_CAST_VO, adapterName: "CastVoAdapter")
class CastVo {
  @JsonKey(name: "adult")
  @HiveField(0)
  bool adult;

  @JsonKey(name: "gender")
  @HiveField(1)
  int gender;

  @JsonKey(name: "id")
  @HiveField(2)
  int id;

  @JsonKey(name: "known_for_department")
  @HiveField(3)
  String knownForDepartment;

  @JsonKey(name: "name")
  @HiveField(4)
  String name;

  @JsonKey(name: "original_name")
  @HiveField(5)
  String originalName;

  @JsonKey(name: "popularity")
  @HiveField(6)
  double popularity;

  @JsonKey(name: "profile_path")
  @HiveField(7)
  String profilePath;

  @JsonKey(name: "cast_id")
  @HiveField(8)
  int castId;

  @JsonKey(name: "character")
  @HiveField(9)
  String character;

  @JsonKey(name: "credit_id")
  @HiveField(10)
  String creditId;

  @JsonKey(name: "order")
  @HiveField(11)
  int order;

  CastVo(
      this.adult,
      this.gender,
      this.id,
      this.knownForDepartment,
      this.name,
      this.originalName,
      this.popularity,
      this.profilePath,
      this.castId,
      this.character,
      this.creditId,
      this.order);

  factory CastVo.fromJson(Map<String, dynamic> json) => _$CastVoFromJson(json);

  Map<String, dynamic> toJson() => _$CastVoToJson(this);

  bool isActor(){
    return knownForDepartment == KNOWN_FOR_DEPARTMENT_ACTING;
  }

  bool isCreator(){
    return knownForDepartment != KNOWN_FOR_DEPARTMENT_ACTING;
  }
}

const String KNOWN_FOR_DEPARTMENT_ACTING = "Acting";
