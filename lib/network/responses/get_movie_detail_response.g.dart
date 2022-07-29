// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_movie_detail_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetMovieDetailResponse _$GetMovieDetailResponseFromJson(
    Map<String, dynamic> json) {
  return GetMovieDetailResponse(
    json['code'] as int,
    json['message'] as String,
    json['data'] == null
        ? null
        : MovieVo.fromJson(json['data'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$GetMovieDetailResponseToJson(
        GetMovieDetailResponse instance) =>
    <String, dynamic>{
      'code': instance.code,
      'message': instance.message,
      'data': instance.data,
    };
