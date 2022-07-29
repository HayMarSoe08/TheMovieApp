// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_user_transaction_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetUserTransactionResponse _$GetUserTransactionResponseFromJson(
    Map<String, dynamic> json) {
  return GetUserTransactionResponse(
    json['code'] as int,
    json['message'] as String,
    json['data'] == null
        ? null
        : CheckOutVo.fromJson(json['data'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$GetUserTransactionResponseToJson(
        GetUserTransactionResponse instance) =>
    <String, dynamic>{
      'code': instance.code,
      'message': instance.message,
      'data': instance.data,
    };
