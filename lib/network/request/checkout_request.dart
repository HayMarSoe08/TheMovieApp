import 'package:json_annotation/json_annotation.dart';
import 'package:student_movie_app/network/request/snack_request.dart';

part 'checkout_request.g.dart';

@JsonSerializable()
class CheckOutRequest {

  @JsonKey(name: "cinema_day_timeslot_id")
  int cinemaDayTimeSlotId;

  @JsonKey(name: "seat_number")
  String seatNumber;

  @JsonKey(name: "booking_date")
  String bookingDate;

  @JsonKey(name: "movie_id")
  int movieId;

  @JsonKey(name: "card_id")
  int cardId;

  @JsonKey(name: "snacks")
  List<SnackRequest> snacks;

  CheckOutRequest(this.cinemaDayTimeSlotId, this.seatNumber, this.bookingDate, this.movieId, this.cardId, this.snacks);

  factory CheckOutRequest.fromJson(Map<String, dynamic> json) => _$CheckOutRequestFromJson(json);

  Map<String, dynamic> toJson() => _$CheckOutRequestToJson(this);

}