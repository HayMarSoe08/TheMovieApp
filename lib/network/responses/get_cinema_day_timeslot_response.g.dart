// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_cinema_day_timeslot_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetCinemaDayTimeslotResponse _$GetCinemaDayTimeslotResponseFromJson(
    Map<String, dynamic> json) {
  return GetCinemaDayTimeslotResponse(
    json['code'] as int,
    json['message'] as String,
    (json['data'] as List)
        ?.map((e) =>
            e == null ? null : CinemaVo.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$GetCinemaDayTimeslotResponseToJson(
        GetCinemaDayTimeslotResponse instance) =>
    <String, dynamic>{
      'code': instance.code,
      'message': instance.message,
      'data': instance.data,
    };
