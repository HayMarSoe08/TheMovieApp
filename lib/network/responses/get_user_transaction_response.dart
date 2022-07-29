import 'package:json_annotation/json_annotation.dart';
import 'package:student_movie_app/data/vos/checkout_vo.dart';

part 'get_user_transaction_response.g.dart';

@JsonSerializable()
class GetUserTransactionResponse{
  @JsonKey(name: "code")
  int code;

  @JsonKey(name: "message")
  String message;

  @JsonKey(name: "data")
  CheckOutVo data;

  GetUserTransactionResponse(this.code, this.message, this.data);

  factory GetUserTransactionResponse.fromJson(Map<String, dynamic> json) => _$GetUserTransactionResponseFromJson(json);

  Map<String, dynamic> toJson() => _$GetUserTransactionResponseToJson(this);
}