import 'package:json_annotation/json_annotation.dart';
import 'package:student_movie_app/data/vos/checkout_vo.dart';

part 'post_checkout_response.g.dart';

@JsonSerializable()
class PostCheckOutResponse{

  @JsonKey(name: "code")
  int code;

  @JsonKey(name: "message")
  String message;

  @JsonKey(name: "data")
  CheckOutVo data;

  PostCheckOutResponse(this.code, this.message, this.data);

  factory PostCheckOutResponse.fromJson(Map<String, dynamic> json) => _$PostCheckOutResponseFromJson(json);

  Map<String, dynamic> toJson() => _$PostCheckOutResponseToJson(this);
}