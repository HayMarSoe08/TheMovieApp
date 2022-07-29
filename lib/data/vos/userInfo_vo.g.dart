// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'userInfo_vo.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class UserInfoVoAdapter extends TypeAdapter<UserInfoVo> {
  @override
  final int typeId = 1;

  @override
  UserInfoVo read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return UserInfoVo(
      fields[0] as int,
      fields[1] as String,
      fields[2] as String,
      fields[3] as String,
      fields[4] as int,
      fields[5] as String,
      (fields[6] as List)?.cast<CardInfoVo>(),
    );
  }

  @override
  void write(BinaryWriter writer, UserInfoVo obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.email)
      ..writeByte(3)
      ..write(obj.phone)
      ..writeByte(4)
      ..write(obj.total_expense)
      ..writeByte(5)
      ..write(obj.profile_image)
      ..writeByte(6)
      ..write(obj.cards);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserInfoVoAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserInfoVo _$UserInfoVoFromJson(Map<String, dynamic> json) {
  return UserInfoVo(
    json['id'] as int,
    json['name'] as String,
    json['email'] as String,
    json['phone'] as String,
    json['total_expense'] as int,
    json['profile_image'] as String,
    (json['cards'] as List)
        ?.map((e) =>
            e == null ? null : CardInfoVo.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$UserInfoVoToJson(UserInfoVo instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'email': instance.email,
      'phone': instance.phone,
      'total_expense': instance.total_expense,
      'profile_image': instance.profile_image,
      'cards': instance.cards,
    };
