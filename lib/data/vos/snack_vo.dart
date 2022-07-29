import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:student_movie_app/persistence/hive_constants.dart';

part 'snack_vo.g.dart';

@JsonSerializable()
@HiveType(typeId: HIVE_TYPE_ID_SNACK, adapterName: "SnackVoAdapter")
class SnackVo {

  @JsonKey(name: "id")
  @HiveField(0)
  int id;

  @JsonKey(name: "name")
  @HiveField(1)
  String name;

  @JsonKey(name: "description")
  @HiveField(2)
  String description;

  @JsonKey(name: "price")
  @HiveField(3)
  double price;

  @JsonKey(name: "unit_price")
  @HiveField(4)
  double unitPrice;

  @JsonKey(name: "image")
  @HiveField(5)
  String image;

  @JsonKey(name: "quantity")
  @HiveField(6)
  int quantity;

  @JsonKey(name: "total_price")
  @HiveField(7)
  double totalPrice;

  SnackVo(this.id, this.name, this.description, this.price, this.unitPrice,
      this.image, this.quantity, this.totalPrice);

  factory SnackVo.fromJson(Map<String, dynamic> json) => _$SnackVoFromJson(json);

  Map<String, dynamic> toJson() => _$SnackVoToJson(this);
}