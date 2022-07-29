import 'package:dio/dio.dart';
import 'package:retrofit/http.dart';
import 'package:student_movie_app/network/request/checkout_request.dart';
import 'package:student_movie_app/network/responses/get_cinema_day_timeslot_response.dart';
import 'package:student_movie_app/network/responses/get_movie_detail_response.dart';
import 'package:student_movie_app/network/responses/get_movie_list_response.dart';
import 'package:student_movie_app/network/responses/get_movie_seat_response.dart';
import 'package:student_movie_app/network/responses/get_profile_response.dart';
import 'package:student_movie_app/network/responses/get_snack_list_response.dart';
import 'package:student_movie_app/network/responses/get_user_transaction_response.dart';
import 'package:student_movie_app/network/responses/logout_response.dart';
import 'package:student_movie_app/network/responses/post_checkout_response.dart';
import 'package:student_movie_app/network/responses/post_create_card_response.dart';
import 'package:student_movie_app/network/responses/post_login_response.dart';

import 'api_constants.dart';

part 'the_movie_api.g.dart';

@RestApi(baseUrl: BASE_URL_DIO)
abstract class TheMovieApi {
  factory TheMovieApi(Dio dio) = _TheMovieApi;

  @POST(ENDPOINT_POST_REGISTER_WITH_EMAIL)
  @FormUrlEncoded()
  Future<PostLoginResponse> postRegisterWithEmail(
      @Header(HEADER_ACCEPT) String accept,
      @Field(PARAM_REGISTER_NAME) String name,
      @Field(PARAM_REGISTER_EMAIL) String email,
      @Field(PARAM_REGISTER_PHONE) String phone,
      @Field(PARAM_REGISTER_PASSWORD) String password,
      {@Field(PARAM_REGISTER_GOOGLE_ACCESS_TOKEN) String googleAccessToken,
      @Field(PARAM_REGISTER_FACEBOOK_ACCESS_TOKEN) String facebookAccessToken});

  @POST(ENDPOINT_POST_LOGIN_WITH_EMAIL)
  @FormUrlEncoded()
  Future<PostLoginResponse> postLoginWithEmail(
    @Header(HEADER_ACCEPT) String accept,
    @Field(PARAM_REGISTER_EMAIL) String email,
    @Field(PARAM_REGISTER_PASSWORD) String password,
  );

  @GET(ENDPOINT_GET_MOVIE_LIST)
  Future<GetMovieListResponse> getMovieList(
    @Query(PARAM_MOVIE_STATUS) String status,
  );

  @POST(ENDPOINT_POST_LOGOUT)
  @FormUrlEncoded()
  Future<LogoutResponse> logout(
    @Header(HEADER_ACCEPT) String accept,
    @Header(HEADER_AUTHORIZATION) String authorization,
  );

  @GET(ENDPOINT_GET_PROFILE)
  Future<GetProfileResponse> getProfile(
    @Header(HEADER_ACCEPT) String accept,
    @Header(HEADER_AUTHORIZATION) String authorization,
  );

  @GET("$ENDPOINT_GET_MOVIE_DETAILS/{movie_id}")
  Future<GetMovieDetailResponse> getMovieDetails(
    @Path("movie_id") int movieId,
  );

  @GET(ENDPOINT_GET_CINEMA_DAY_TIMESLOT)
  Future<GetCinemaDayTimeslotResponse> getCinemaDayTimeslot(
      @Header(HEADER_ACCEPT) String accept,
      @Header(HEADER_AUTHORIZATION) String authorization,
      @Query(PARAM_DATE) String date,
      );

  @GET(ENDPOINT_GET_CINEMA_SEATING_PLAN)
  Future<GetMovieSeatsResponse> getMovieSeatingPlan(
      @Header(HEADER_ACCEPT) String accept,
      @Header(HEADER_AUTHORIZATION) String authorization,
      @Query(PARAM_CINEMA_DAY_TIMESLOTS_ID) int cinemaDayTimeslotId,
      @Query(PARAM_BOOKING_DATE) String bookingDate,
      );

  @GET(ENDPOINT_GET_SNACK_LIST)
  Future<GetSnackListResponse> getSnackList(
      @Header(HEADER_ACCEPT) String accept,
      @Header(HEADER_AUTHORIZATION) String authorization,
      );

  @POST(ENDPOINT_POST_CREATE_CARD)
  @FormUrlEncoded()
  Future<PostCreateCardResponse> postCreateCard(
      @Header(HEADER_ACCEPT) String accept,
      @Header(HEADER_AUTHORIZATION) String authorization,
      @Field(PARAM_CARD_NUMBER) String cardNumber,
      @Field(PARAM_CARD_HOLDER) String cardHolder,
      @Field(PARAM_EXPIRATION_DATE) String expireDate,
      @Field(PARAM_CVC) int cvc,
      );

  @GET(ENDPOINT_GET_USER_TRANSACTION)
  Future<GetUserTransactionResponse> getUserTransaction(
      @Header(HEADER_AUTHORIZATION) String authorization,
      );

  @POST(ENDPOINT_POST_CHECKOUT)
  Future<PostCheckOutResponse> checkOut(
      @Header(HEADER_AUTHORIZATION) String authorization,
      @Body() CheckOutRequest checkOutRequest,
      );

  @POST(ENDPOINT_POST_LOGIN_WITH_FACEBOOK)
  @FormUrlEncoded()
  Future<PostLoginResponse> loginWithFacebook(
      @Header(HEADER_ACCEPT) String accept,
      @Field(PARAM_ACCESS_TOKEN) String accessToken,
      );

  @POST(ENDPOINT_POST_LOGIN_WITH_GOOGLE)
  @FormUrlEncoded()
  Future<PostLoginResponse> loginWithGoogle(
      @Header(HEADER_ACCEPT) String accept,
      @Field(PARAM_ACCESS_TOKEN) String accessToken,
      );
}
