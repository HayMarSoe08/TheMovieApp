// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'post_login_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PostLoginResponse _$PostLoginResponseFromJson(Map<String, dynamic> json) {
  return PostLoginResponse(
    json['code'] as int,
    json['message'] as String,
    json['data'] == null
        ? null
        : UserInfoVo.fromJson(json['data'] as Map<String, dynamic>),
    json['token'] as String,
  );
}

Map<String, dynamic> _$PostLoginResponseToJson(PostLoginResponse instance) =>
    <String, dynamic>{
      'code': instance.code,
      'message': instance.message,
      'data': instance.data,
      'token': instance.token,
    };
