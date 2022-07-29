import 'package:student_movie_app/data/vos/cast_vo.dart';
import 'package:student_movie_app/data/vos/checkout_vo.dart';
import 'package:student_movie_app/data/vos/cinema_vo.dart';
import 'package:student_movie_app/data/vos/movie_seat_vo.dart';
import 'package:student_movie_app/data/vos/movie_vo.dart';
import 'package:student_movie_app/data/vos/snack_vo.dart';
import 'package:student_movie_app/network/request/checkout_request.dart';
import 'package:student_movie_app/network/responses/post_checkout_response.dart';

abstract class MovieModel {
  // Network
  void getMovieList(String status);
  void getMovieDetails(int movieId);
  void getCinemaDayTimeslot(String date);
  Future<List<List<MovieSeatVO>>> getMovieSeatingPlan(
      int cinemaDayTimeslotId, String bookingDate);
  void getSnackList();
  Future<CheckOutVo> getUserTransaction();
  Future<CheckOutVo> postCheckOut(
      int cinemaDayTimeSlotId,
      String seatNumber,
      String bookingDate,
      int movieId,
      int cardId,
      List<SnackVo> snackList);

  // Database
  Stream<List<MovieVo>> getNowPlayingMovieListFromDatabase();
  Stream<List<MovieVo>> getComingSoonMovieListFromDatabase();
  Stream<MovieVo> getMovieDetailsFromDatabase(int movieId);
  Stream<List<CastVo>> getAllCastFromDatabase();
  Stream<List<CinemaVo>> getCinemaDayTimeslotFromDatabase(String date);
  Stream<List<SnackVo>> getSnackListFromDatabase();

}
