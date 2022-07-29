// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'movie_seat_vo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MovieSeatVO _$MovieSeatVOFromJson(Map<String, dynamic> json) {
  return MovieSeatVO(
    json['id'] as int,
    json['type'] as String,
    json['seat_name'] as String,
    json['symbol'] as String,
    (json['price'] as num)?.toDouble(),
    json['isSelected'] as bool,
  );
}

Map<String, dynamic> _$MovieSeatVOToJson(MovieSeatVO instance) =>
    <String, dynamic>{
      'id': instance.id,
      'type': instance.type,
      'seat_name': instance.seatName,
      'symbol': instance.symbol,
      'price': instance.price,
      'isSelected': instance.isSelected,
    };
