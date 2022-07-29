import 'package:student_movie_app/data/vos/cardInfo_vo.dart';
import 'package:student_movie_app/data/vos/checkout_vo.dart';
import 'package:student_movie_app/data/vos/cinema_vo.dart';
import 'package:student_movie_app/data/vos/movie_seat_vo.dart';
import 'package:student_movie_app/data/vos/movie_vo.dart';
import 'package:student_movie_app/data/vos/snack_vo.dart';
import 'package:student_movie_app/data/vos/userInfo_vo.dart';
import 'package:student_movie_app/network/request/checkout_request.dart';
import 'package:student_movie_app/network/responses/get_movie_detail_response.dart';
import 'package:student_movie_app/network/responses/get_movie_list_response.dart';
import 'package:student_movie_app/network/responses/get_profile_response.dart';
import 'package:student_movie_app/network/responses/logout_response.dart';
import 'package:student_movie_app/network/responses/post_checkout_response.dart';
import 'package:student_movie_app/network/responses/post_login_response.dart';

abstract class MovieDataAgent {
  Future<PostLoginResponse> postRegisterWithEmail(
      String name, String email, String phone, String password,
      {String googleAccessToken, String facebookAccessToken});

  Future<PostLoginResponse> postLoginWithEmail(String email, String password);

  Future<List<MovieVo>> getMovieList(String status);

  Future<LogoutResponse> logout(String token);

  Future<GetProfileResponse> getProfile(String token);

  Future<MovieVo> getMovieDetails(int movieId);

  Future<List<CinemaVo>> getCinemaDayTimeslot(String token, String date);

  Future<List<List<MovieSeatVO>>> getMovieSeatingPlan(String token, int cinemaDayTimeslotId, String bookingDate);

  Future<List<SnackVo>> getSnackList(String token);

  Future<List<CardInfoVo>> postCreateCard(String token, String cardNumber, String cardHolder, String expireDate, int cvc);

  Future<CheckOutVo> getUserTransaction(String token);

  Future<CheckOutVo> postCheckOut(String token, CheckOutRequest checkOutRequest);

  Future<PostLoginResponse> postLoginWithFacebook(String accessToken);

  Future<PostLoginResponse> postLoginWithGoogle(String accessToken);

}
