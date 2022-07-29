
import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:student_movie_app/persistence/hive_constants.dart';

part 'cardInfo_vo.g.dart';

@JsonSerializable()
@HiveType(typeId: HIVE_TYPE_ID_CARD_VO, adapterName: "CardInfoVoAdapter")
class CardInfoVo {

  @JsonKey(name: "id")
  @HiveField(0)
  int id;

  @JsonKey(name: "card_holder")
  @HiveField(1)
  String cardHolder;

  @JsonKey(name: "card_number")
  @HiveField(2)
  String cardNumber;

  @JsonKey(name: "expiration_date")
  @HiveField(3)
  String expirationDate;

  @JsonKey(name: "card_type")
  @HiveField(4)
  String cardType;


  CardInfoVo(this.id, this.cardHolder, this.cardNumber, this.expirationDate,
      this.cardType);

  factory CardInfoVo.fromJson(Map<String, dynamic> json) => _$CardInfoVoFromJson(json);

  Map<String, dynamic> toJson() => _$CardInfoVoToJson(this);
}