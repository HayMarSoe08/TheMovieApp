import 'package:flutter/cupertino.dart';
import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:student_movie_app/data/vos/timeslots_vo.dart';
import 'package:student_movie_app/persistence/hive_constants.dart';

part 'cinema_vo.g.dart';

@JsonSerializable()
@HiveType(typeId: HIVE_TYPE_ID_CINEMA_VO, adapterName: "CinemaVoAdapter")
class CinemaVo {
  @JsonKey(name: "cinema_id")
  @HiveField(0)
  int cinemaId;

  @JsonKey(name: "cinema")
  @HiveField(1)
  String cinema;

  @JsonKey(name: "timeslots")
  @HiveField(2)
  List<TimeslotsVo> timeslots;

  @JsonKey(ignore: true)
  @HiveField(3)
  List<String> dates;

  CinemaVo(this.cinemaId, this.cinema, this.timeslots, {this.dates = const ["2021-07-06"]});

  factory CinemaVo.fromJson(Map<String, dynamic> json) =>
      _$CinemaVoFromJson(json);

  Map<String, dynamic> toJson() => _$CinemaVoToJson(this);
}

