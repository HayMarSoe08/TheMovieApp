// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_movie_seat_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetMovieSeatsResponse _$GetMovieSeatsResponseFromJson(
    Map<String, dynamic> json) {
  return GetMovieSeatsResponse(
    json['code'] as int,
    json['message'] as String,
    (json['data'] as List)
        ?.map((e) => (e as List)
            ?.map((e) => e == null
                ? null
                : MovieSeatVO.fromJson(e as Map<String, dynamic>))
            ?.toList())
        ?.toList(),
  );
}

Map<String, dynamic> _$GetMovieSeatsResponseToJson(
        GetMovieSeatsResponse instance) =>
    <String, dynamic>{
      'code': instance.code,
      'message': instance.message,
      'data': instance.data,
    };
