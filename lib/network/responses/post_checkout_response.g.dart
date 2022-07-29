// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'post_checkout_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PostCheckOutResponse _$PostCheckOutResponseFromJson(Map<String, dynamic> json) {
  return PostCheckOutResponse(
    json['code'] as int,
    json['message'] as String,
    json['data'] == null
        ? null
        : CheckOutVo.fromJson(json['data'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$PostCheckOutResponseToJson(
        PostCheckOutResponse instance) =>
    <String, dynamic>{
      'code': instance.code,
      'message': instance.message,
      'data': instance.data,
    };
