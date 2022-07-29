// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'the_movie_api.dart';

// **************************************************************************
// RetrofitGenerator
// **************************************************************************

class _TheMovieApi implements TheMovieApi {
  _TheMovieApi(this._dio, {this.baseUrl}) {
    ArgumentError.checkNotNull(_dio, '_dio');
    baseUrl ??= 'https://tmba.padc.com.mm';
  }

  final Dio _dio;

  String baseUrl;

  @override
  Future<PostLoginResponse> postRegisterWithEmail(
      accept, name, email, phone, password,
      {googleAccessToken, facebookAccessToken}) async {
    ArgumentError.checkNotNull(accept, 'accept');
    ArgumentError.checkNotNull(name, 'name');
    ArgumentError.checkNotNull(email, 'email');
    ArgumentError.checkNotNull(phone, 'phone');
    ArgumentError.checkNotNull(password, 'password');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    queryParameters.removeWhere((k, v) => v == null);
    final _data = {
      'name': name,
      'email': email,
      'phone': phone,
      'password': password,
      'google-access-token': googleAccessToken,
      'facebook-access-token': facebookAccessToken
    };
    _data.removeWhere((k, v) => v == null);
    final _result = await _dio.request<Map<String, dynamic>>('/api/v1/register',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'POST',
            headers: <String, dynamic>{r'Accept': accept},
            extra: _extra,
            contentType: 'application/x-www-form-urlencoded',
            baseUrl: baseUrl),
        data: _data);
    final value = PostLoginResponse.fromJson(_result.data);
    return value;
  }

  @override
  Future<PostLoginResponse> postLoginWithEmail(accept, email, password) async {
    ArgumentError.checkNotNull(accept, 'accept');
    ArgumentError.checkNotNull(email, 'email');
    ArgumentError.checkNotNull(password, 'password');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = {'email': email, 'password': password};
    _data.removeWhere((k, v) => v == null);
    final _result = await _dio.request<Map<String, dynamic>>(
        '/api/v1/email-login',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'POST',
            headers: <String, dynamic>{r'Accept': accept},
            extra: _extra,
            contentType: 'application/x-www-form-urlencoded',
            baseUrl: baseUrl),
        data: _data);
    final value = PostLoginResponse.fromJson(_result.data);
    return value;
  }

  @override
  Future<GetMovieListResponse> getMovieList(status) async {
    ArgumentError.checkNotNull(status, 'status');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{r'status': status};
    final _data = <String, dynamic>{};
    final _result = await _dio.request<Map<String, dynamic>>('/api/v1/movies',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'GET',
            headers: <String, dynamic>{},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = GetMovieListResponse.fromJson(_result.data);
    return value;
  }

  @override
  Future<LogoutResponse> logout(accept, authorization) async {
    ArgumentError.checkNotNull(accept, 'accept');
    ArgumentError.checkNotNull(authorization, 'authorization');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.request<Map<String, dynamic>>('/api/v1/logout',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'POST',
            headers: <String, dynamic>{
              r'Accept': accept,
              r'Authorization': authorization
            },
            extra: _extra,
            contentType: 'application/x-www-form-urlencoded',
            baseUrl: baseUrl),
        data: _data);
    final value = LogoutResponse.fromJson(_result.data);
    return value;
  }

  @override
  Future<GetProfileResponse> getProfile(accept, authorization) async {
    ArgumentError.checkNotNull(accept, 'accept');
    ArgumentError.checkNotNull(authorization, 'authorization');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.request<Map<String, dynamic>>('/api/v1/profile',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'GET',
            headers: <String, dynamic>{
              r'Accept': accept,
              r'Authorization': authorization
            },
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = GetProfileResponse.fromJson(_result.data);
    return value;
  }

  @override
  Future<GetMovieDetailResponse> getMovieDetails(movieId) async {
    ArgumentError.checkNotNull(movieId, 'movieId');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.request<Map<String, dynamic>>(
        '/api/v1/movies/$movieId',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'GET',
            headers: <String, dynamic>{},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = GetMovieDetailResponse.fromJson(_result.data);
    return value;
  }

  @override
  Future<GetCinemaDayTimeslotResponse> getCinemaDayTimeslot(
      accept, authorization, date) async {
    ArgumentError.checkNotNull(accept, 'accept');
    ArgumentError.checkNotNull(authorization, 'authorization');
    ArgumentError.checkNotNull(date, 'date');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{r'date': date};
    final _data = <String, dynamic>{};
    final _result = await _dio.request<Map<String, dynamic>>(
        '/api/v1/cinema-day-timeslots',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'GET',
            headers: <String, dynamic>{
              r'Accept': accept,
              r'Authorization': authorization
            },
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = GetCinemaDayTimeslotResponse.fromJson(_result.data);
    return value;
  }

  @override
  Future<GetMovieSeatsResponse> getMovieSeatingPlan(
      accept, authorization, cinemaDayTimeslotId, bookingDate) async {
    ArgumentError.checkNotNull(accept, 'accept');
    ArgumentError.checkNotNull(authorization, 'authorization');
    ArgumentError.checkNotNull(cinemaDayTimeslotId, 'cinemaDayTimeslotId');
    ArgumentError.checkNotNull(bookingDate, 'bookingDate');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{
      r'cinema_day_timeslot_id': cinemaDayTimeslotId,
      r'booking_date': bookingDate
    };
    final _data = <String, dynamic>{};
    final _result = await _dio.request<Map<String, dynamic>>(
        '/api/v1/seat-plan',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'GET',
            headers: <String, dynamic>{
              r'Accept': accept,
              r'Authorization': authorization
            },
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = GetMovieSeatsResponse.fromJson(_result.data);
    return value;
  }

  @override
  Future<GetSnackListResponse> getSnackList(accept, authorization) async {
    ArgumentError.checkNotNull(accept, 'accept');
    ArgumentError.checkNotNull(authorization, 'authorization');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.request<Map<String, dynamic>>('/api/v1/snacks',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'GET',
            headers: <String, dynamic>{
              r'Accept': accept,
              r'Authorization': authorization
            },
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = GetSnackListResponse.fromJson(_result.data);
    return value;
  }

  @override
  Future<PostCreateCardResponse> postCreateCard(
      accept, authorization, cardNumber, cardHolder, expireDate, cvc) async {
    ArgumentError.checkNotNull(accept, 'accept');
    ArgumentError.checkNotNull(authorization, 'authorization');
    ArgumentError.checkNotNull(cardNumber, 'cardNumber');
    ArgumentError.checkNotNull(cardHolder, 'cardHolder');
    ArgumentError.checkNotNull(expireDate, 'expireDate');
    ArgumentError.checkNotNull(cvc, 'cvc');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = {
      'card_number': cardNumber,
      'card_holder': cardHolder,
      'expiration_date': expireDate,
      'cvc': cvc
    };
    _data.removeWhere((k, v) => v == null);
    final _result = await _dio.request<Map<String, dynamic>>('/api/v1/card',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'POST',
            headers: <String, dynamic>{
              r'Accept': accept,
              r'Authorization': authorization
            },
            extra: _extra,
            contentType: 'application/x-www-form-urlencoded',
            baseUrl: baseUrl),
        data: _data);
    final value = PostCreateCardResponse.fromJson(_result.data);
    return value;
  }

  @override
  Future<GetUserTransactionResponse> getUserTransaction(authorization) async {
    ArgumentError.checkNotNull(authorization, 'authorization');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.request<Map<String, dynamic>>(
        '/api/v1/profile/transactions',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'GET',
            headers: <String, dynamic>{r'Authorization': authorization},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = GetUserTransactionResponse.fromJson(_result.data);
    return value;
  }

  @override
  Future<PostCheckOutResponse> checkOut(authorization, checkOutRequest) async {
    ArgumentError.checkNotNull(authorization, 'authorization');
    ArgumentError.checkNotNull(checkOutRequest, 'checkOutRequest');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(checkOutRequest?.toJson() ?? <String, dynamic>{});
    final _result = await _dio.request<Map<String, dynamic>>('/api/v1/checkout',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'POST',
            headers: <String, dynamic>{r'Authorization': authorization},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = PostCheckOutResponse.fromJson(_result.data);
    return value;
  }

  @override
  Future<PostLoginResponse> loginWithFacebook(accept, accessToken) async {
    ArgumentError.checkNotNull(accept, 'accept');
    ArgumentError.checkNotNull(accessToken, 'accessToken');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = {'access-token': accessToken};
    _data.removeWhere((k, v) => v == null);
    final _result = await _dio.request<Map<String, dynamic>>(
        '/api/v1/facebook-login',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'POST',
            headers: <String, dynamic>{r'Accept': accept},
            extra: _extra,
            contentType: 'application/x-www-form-urlencoded',
            baseUrl: baseUrl),
        data: _data);
    final value = PostLoginResponse.fromJson(_result.data);
    return value;
  }

  @override
  Future<PostLoginResponse> loginWithGoogle(accept, accessToken) async {
    ArgumentError.checkNotNull(accept, 'accept');
    ArgumentError.checkNotNull(accessToken, 'accessToken');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = {'access-token': accessToken};
    _data.removeWhere((k, v) => v == null);
    final _result = await _dio.request<Map<String, dynamic>>(
        '/api/v1/google-login',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'POST',
            headers: <String, dynamic>{r'Accept': accept},
            extra: _extra,
            contentType: 'application/x-www-form-urlencoded',
            baseUrl: baseUrl),
        data: _data);
    final value = PostLoginResponse.fromJson(_result.data);
    return value;
  }
}
