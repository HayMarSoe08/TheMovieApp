
import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:student_movie_app/persistence/hive_constants.dart';

part 'timeslots_vo.g.dart';

@JsonSerializable()
@HiveType(typeId: HIVE_TYPE_ID_TIMESLOT, adapterName: "TimeslotsVoAdapter")
class TimeslotsVo{
  @JsonKey(name: "cinema_day_timeslot_id")
  @HiveField(4)
  int cinemaDayTimeslotId;

  @JsonKey(name: "start_time")
  @HiveField(5)
  String startTime;

  @JsonKey(ignore: true)
  @HiveField(6)
  bool isSelected;

  TimeslotsVo(this.cinemaDayTimeslotId, this.startTime, {this.isSelected});

  factory TimeslotsVo.fromJson(Map<String, dynamic> json) => _$TimeslotsVoFromJson(json);

  Map<String, dynamic> toJson() => _$TimeslotsVoToJson(this);
}