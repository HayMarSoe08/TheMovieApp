// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'timeslots_vo.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class TimeslotsVoAdapter extends TypeAdapter<TimeslotsVo> {
  @override
  final int typeId = 8;

  @override
  TimeslotsVo read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return TimeslotsVo(
      fields[4] as int,
      fields[5] as String,
      isSelected: fields[6] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, TimeslotsVo obj) {
    writer
      ..writeByte(3)
      ..writeByte(4)
      ..write(obj.cinemaDayTimeslotId)
      ..writeByte(5)
      ..write(obj.startTime)
      ..writeByte(6)
      ..write(obj.isSelected);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TimeslotsVoAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TimeslotsVo _$TimeslotsVoFromJson(Map<String, dynamic> json) {
  return TimeslotsVo(
    json['cinema_day_timeslot_id'] as int,
    json['start_time'] as String,
  );
}

Map<String, dynamic> _$TimeslotsVoToJson(TimeslotsVo instance) =>
    <String, dynamic>{
      'cinema_day_timeslot_id': instance.cinemaDayTimeslotId,
      'start_time': instance.startTime,
    };
