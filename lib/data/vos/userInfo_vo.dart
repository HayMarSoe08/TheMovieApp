
import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:student_movie_app/data/vos/cardInfo_vo.dart';
import 'package:student_movie_app/persistence/hive_constants.dart';

part 'userInfo_vo.g.dart';

@JsonSerializable()
@HiveType(typeId: HIVE_TYPE_ID_USER_VO, adapterName: "UserInfoVoAdapter")
class UserInfoVo {

  @JsonKey(name: "id")
  @HiveField(0)
  int id;

  @JsonKey(name: "name")
  @HiveField(1)
  String name;

  @JsonKey(name: "email")
  @HiveField(2)
  String email;

  @JsonKey(name: "phone")
  @HiveField(3)
  String phone;

  @JsonKey(name: "total_expense")
  @HiveField(4)
  int total_expense;

  @JsonKey(name: "profile_image")
  @HiveField(5)
  String profile_image;

  @JsonKey(name: "cards")
  @HiveField(6)
  List<CardInfoVo> cards;

  UserInfoVo(this.id, this.name, this.email, this.phone, this.total_expense,
      this.profile_image, this.cards);

  factory UserInfoVo.fromJson(Map<String, dynamic> json) => _$UserInfoVoFromJson(json);

  Map<String, dynamic> toJson() => _$UserInfoVoToJson(this);

}