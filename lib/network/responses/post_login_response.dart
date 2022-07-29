import 'package:json_annotation/json_annotation.dart';
import 'package:student_movie_app/data/vos/userInfo_vo.dart';

part 'post_login_response.g.dart';

@JsonSerializable()
class PostLoginResponse {

  @JsonKey(name: "code")
  int code;

  @JsonKey(name: "message")
  String message;

  @JsonKey(name: "data")
  UserInfoVo data;

  @JsonKey(name: "token")
  String token;

  PostLoginResponse(this.code, this.message, this.data, this.token);

  factory PostLoginResponse.fromJson(Map<String, dynamic> json) => _$PostLoginResponseFromJson(json);

  Map<String, dynamic> toJson() => _$PostLoginResponseToJson(this);

}