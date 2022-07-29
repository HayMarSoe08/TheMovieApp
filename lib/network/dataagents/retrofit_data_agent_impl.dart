import 'dart:io';

import 'package:dio/dio.dart';
import 'package:student_movie_app/data/vos/cardInfo_vo.dart';
import 'package:student_movie_app/data/vos/checkout_vo.dart';
import 'package:student_movie_app/data/vos/cinema_vo.dart';
import 'package:student_movie_app/data/vos/movie_seat_vo.dart';
import 'package:student_movie_app/data/vos/movie_vo.dart';
import 'package:student_movie_app/data/vos/snack_vo.dart';
import 'package:student_movie_app/network/dataagents/movie_data_agent.dart';
import 'package:student_movie_app/network/request/checkout_request.dart';
import 'package:student_movie_app/network/responses/get_movie_detail_response.dart';
import 'package:student_movie_app/network/responses/get_movie_list_response.dart';
import 'package:student_movie_app/network/responses/get_profile_response.dart';
import 'package:student_movie_app/network/responses/logout_response.dart';
import 'package:student_movie_app/network/responses/post_checkout_response.dart';
import 'package:student_movie_app/network/responses/post_login_response.dart';
import 'package:student_movie_app/network/the_movie_api.dart';

import '../api_constants.dart';

class RetrofitDataAgentImpl extends MovieDataAgent {
  TheMovieApi mApi;

  static final RetrofitDataAgentImpl _singleton =
      RetrofitDataAgentImpl._internal();

  factory RetrofitDataAgentImpl() {
    return _singleton;
  }

  RetrofitDataAgentImpl._internal() {
    final dio = Dio();
    mApi = TheMovieApi(dio);
  }

  // Register With Email
  @override
  Future<PostLoginResponse> postRegisterWithEmail(
      String name, String email, String phone, String password,
      {String googleAccessToken, String facebookAccessToken}) {
    return mApi
        .postRegisterWithEmail(ACCEPT, name, email, phone, password,
            googleAccessToken: googleAccessToken,
            facebookAccessToken: facebookAccessToken)
        .asStream()
        .map((response) => response)
        .first;
  }

  // Login With Email
  @override
  Future<PostLoginResponse> postLoginWithEmail(String email, String password) {
    return mApi
        .postLoginWithEmail(ACCEPT, email, password)
        .asStream()
        .map((response) => response)
        .first;
  }

  // Login With Facebook
  @override
  Future<PostLoginResponse> postLoginWithFacebook(String accessToken){
    return mApi
        .loginWithFacebook(ACCEPT, accessToken)
        .asStream()
        .map((response) => response)
        .first;
  }

  // Login With Google
  @override
  Future<PostLoginResponse> postLoginWithGoogle(String accessToken){
    return mApi
        .loginWithGoogle(ACCEPT, accessToken)
        .asStream()
        .map((response) => response)
        .first;
  }

  // Get Movie List
  @override
  Future<List<MovieVo>> getMovieList(String status) {
    return mApi
        .getMovieList(status)
        .asStream()
        .map((response) => response.data)
        .first;
  }

  // Logout
  @override
  Future<LogoutResponse> logout(String token) {
    return mApi
        .logout(ACCEPT, "Bearer $token")
        .asStream()
        .map((response) => response)
        .first;
  }

  // Get Profile
  @override
  Future<GetProfileResponse> getProfile(String token) {
    return mApi
        .getProfile(ACCEPT, "Bearer $token")
        .asStream()
        .map((response) => response)
        .first;
  }

  // Get Movie Details
  @override
  Future<MovieVo> getMovieDetails(int movieId) {
    return mApi
        .getMovieDetails(movieId)
        .asStream()
        .map((response) => response.data)
        .first;
  }

  // Get Cinema Day TimeSlots
  @override
  Future<List<CinemaVo>> getCinemaDayTimeslot(String token, String date) {
    return mApi
        .getCinemaDayTimeslot(ACCEPT, "Bearer $token", date)
        .asStream()
        .map((response) => response.data)
        .first;
  }

  // Get Movie Seating Plan
  @override
  Future<List<List<MovieSeatVO>>> getMovieSeatingPlan(
      String token, int cinemaDayTimeslotId, String bookingDate) {
    return mApi
        .getMovieSeatingPlan(
            ACCEPT, "Bearer $token", cinemaDayTimeslotId, bookingDate)
        .asStream()
        .map((response) => response.data)
        .first;
  }

  // Get Snack List
  @override
  Future<List<SnackVo>> getSnackList(String token) {
    return mApi
        .getSnackList(ACCEPT, "Bearer $token")
        .asStream()
        .map((response) => response.data)
        .first;
  }

  // Create Card
  @override
  Future<List<CardInfoVo>> postCreateCard(String token, String cardNumber,
      String cardHolder, String expireDate, int cvc) {
    return mApi
        .postCreateCard(
            ACCEPT, "Bearer $token", cardNumber, cardHolder, expireDate, cvc)
        .asStream()
        .map((response) => response.data)
        .first;
  }

  // User Transaction
  @override
  Future<CheckOutVo> getUserTransaction(String token) {
    return mApi
        .getUserTransaction("Bearer $token")
        .asStream()
        .map((response) => response.data)
        .first;
  }

  // CheckOut
  @override
  Future<CheckOutVo> postCheckOut(
      String token, CheckOutRequest checkOutRequest) {
    return mApi
        .checkOut("Bearer $token", checkOutRequest)
        .then((response) {
          if (response.code == RESPONSE_CODE_SUCCESS) {
            return Future<PostCheckOutResponse>.value(response);
          } else {
            return Future<PostCheckOutResponse>.error(response.message);
          }
        })
        .asStream()
        .map((response) => response.data)
        .first;
  }

}
