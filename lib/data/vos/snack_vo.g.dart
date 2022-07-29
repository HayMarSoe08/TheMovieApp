// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'snack_vo.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class SnackVoAdapter extends TypeAdapter<SnackVo> {
  @override
  final int typeId = 7;

  @override
  SnackVo read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return SnackVo(
      fields[0] as int,
      fields[1] as String,
      fields[2] as String,
      fields[3] as double,
      fields[4] as double,
      fields[5] as String,
      fields[6] as int,
      fields[7] as double,
    );
  }

  @override
  void write(BinaryWriter writer, SnackVo obj) {
    writer
      ..writeByte(8)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.description)
      ..writeByte(3)
      ..write(obj.price)
      ..writeByte(4)
      ..write(obj.unitPrice)
      ..writeByte(5)
      ..write(obj.image)
      ..writeByte(6)
      ..write(obj.quantity)
      ..writeByte(7)
      ..write(obj.totalPrice);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SnackVoAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SnackVo _$SnackVoFromJson(Map<String, dynamic> json) {
  return SnackVo(
    json['id'] as int,
    json['name'] as String,
    json['description'] as String,
    (json['price'] as num)?.toDouble(),
    (json['unit_price'] as num)?.toDouble(),
    json['image'] as String,
    json['quantity'] as int,
    (json['total_price'] as num)?.toDouble(),
  );
}

Map<String, dynamic> _$SnackVoToJson(SnackVo instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'price': instance.price,
      'unit_price': instance.unitPrice,
      'image': instance.image,
      'quantity': instance.quantity,
      'total_price': instance.totalPrice,
    };
