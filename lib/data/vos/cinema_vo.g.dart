// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cinema_vo.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CinemaVoAdapter extends TypeAdapter<CinemaVo> {
  @override
  final int typeId = 6;

  @override
  CinemaVo read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return CinemaVo(
      fields[0] as int,
      fields[1] as String,
      (fields[2] as List)?.cast<TimeslotsVo>(),
      dates: (fields[3] as List)?.cast<String>(),
    );
  }

  @override
  void write(BinaryWriter writer, CinemaVo obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.cinemaId)
      ..writeByte(1)
      ..write(obj.cinema)
      ..writeByte(2)
      ..write(obj.timeslots)
      ..writeByte(3)
      ..write(obj.dates);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CinemaVoAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CinemaVo _$CinemaVoFromJson(Map<String, dynamic> json) {
  return CinemaVo(
    json['cinema_id'] as int,
    json['cinema'] as String,
    (json['timeslots'] as List)
        ?.map((e) =>
            e == null ? null : TimeslotsVo.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$CinemaVoToJson(CinemaVo instance) => <String, dynamic>{
      'cinema_id': instance.cinemaId,
      'cinema': instance.cinema,
      'timeslots': instance.timeslots,
    };
