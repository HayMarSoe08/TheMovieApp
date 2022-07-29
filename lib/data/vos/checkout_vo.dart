import 'package:json_annotation/json_annotation.dart';
import 'package:student_movie_app/data/vos/snack_vo.dart';
import 'package:student_movie_app/data/vos/timeslots_vo.dart';

part 'checkout_vo.g.dart';

@JsonSerializable()
class CheckOutVo {

  @JsonKey(name: "id")
  int id;

  @JsonKey(name: "booking_no")
  String bookingNo;

  @JsonKey(name: "booking_date")
  String bookingDate;

  @JsonKey(name: "row")
  String row;

  @JsonKey(name: "seat")
  String seat;

  @JsonKey(name: "total_seat")
  int totalSeat;

  @JsonKey(name: "total")
  String total;

  @JsonKey(name: "movie_id")
  int movieId;

  @JsonKey(name: "cinema_id")
  int cinemaId;

  @JsonKey(name: "username")
  String username;

  @JsonKey(name: "timeslot")
  TimeslotsVo timeslot;

  @JsonKey(name: "snacks")
  List<SnackVo> snacks;

  CheckOutVo(
      this.id,
      this.bookingNo,
      this.bookingDate,
      this.row,
      this.seat,
      this.totalSeat,
      this.total,
      this.movieId,
      this.cinemaId,
      this.username,
      this.timeslot,
      this.snacks);

  factory CheckOutVo.fromJson(Map<String, dynamic> json) => _$CheckOutVoFromJson(json);

  Map<String, dynamic> toJson() => _$CheckOutVoToJson(this);
}