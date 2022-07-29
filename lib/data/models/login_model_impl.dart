import 'package:student_movie_app/data/models/lgoin_model.dart';
import 'package:student_movie_app/data/vos/cardInfo_vo.dart';
import 'package:student_movie_app/data/vos/userInfo_vo.dart';
import 'package:student_movie_app/network/dataagents/movie_data_agent.dart';
import 'package:student_movie_app/network/dataagents/retrofit_data_agent_impl.dart';
import 'package:student_movie_app/network/responses/get_profile_response.dart';
import 'package:student_movie_app/network/responses/logout_response.dart';
import 'package:student_movie_app/network/responses/post_login_response.dart';
import 'package:student_movie_app/persistence/daos/login_dao.dart';
import 'package:stream_transform/stream_transform.dart';

class LoginModelImpl extends LoginModel {
  MovieDataAgent mDataAgent = RetrofitDataAgentImpl();

  LoginDao mLoginDao = new LoginDao();

  static final LoginModelImpl _singleton = LoginModelImpl._internal();

  factory LoginModelImpl() {
    return _singleton;
  }

  LoginModelImpl._internal();

  //Network
  // RegisterWithEmail
  @override
  Future<PostLoginResponse> postRegisterWithEmail(
      String name, String email, String phone, String password,
      {String googleAccessToken, String facebookAccessToken}) {
    return mDataAgent
        .postRegisterWithEmail(name, email, phone, password,
            googleAccessToken: googleAccessToken,
            facebookAccessToken: facebookAccessToken)
        .then((registerData) async {
      mLoginDao.saveUserInfo(registerData.data);
      mLoginDao.saveToken(registerData.token);
      return Future.value(registerData);
    });
  }

  // LoginWithEmail
  @override
  Future<PostLoginResponse> postLoginWithEmail(String email, String password) {
    return mDataAgent
        .postLoginWithEmail(email, password)
        .then((loginData) async {
      mLoginDao.saveUserInfo(loginData.data);
      mLoginDao.saveToken(loginData.token);

      return Future.value(loginData);
    });
  }

  // Login With Facebook
  @override
  Future<PostLoginResponse> postLoginWithFacebook(String accessToken) {
    return mDataAgent
        .postLoginWithFacebook(accessToken)
        .then((loginData) async {
      mLoginDao.saveUserInfo(loginData.data);
      mLoginDao.saveToken(loginData.token);

      return Future.value(loginData);
    });
  }

  // Login With Googlemessage = "There's no registered account with this google account."
  @override
  Future<PostLoginResponse> postLoginWithGoogle(String accessToken) {
    return mDataAgent.postLoginWithGoogle(accessToken).then((loginData) async {
      mLoginDao.saveUserInfo(loginData.data);
      mLoginDao.saveToken(loginData.token);

      return Future.value(loginData);
    });
  }

  // Logout
  @override
  Future<LogoutResponse> logout() {
    String token;
    token = getToken();
    return mDataAgent.logout(token).then((value) async {
      mLoginDao.deleteToken();

      return Future.value(value);
    });
  }

  // GetProfile
  @override
  void getProfile() {
    String token;
    token = getToken();
    mDataAgent
        .getProfile(token)
        .then((value) => mLoginDao.saveUserInfo(value.data));
  }

  // Create Card
  @override
  Future<List<CardInfoVo>> postCreateCard(
      String cardNumber, String cardHolder, String expireDate, int cvc) {
    String token;
    token = getToken();
    //return Future.value(mDataAgent.postCreateCard(
    //  token, cardNumber, cardHolder, expireDate, cvc));
    return mDataAgent
        .postCreateCard(token, cardNumber, cardHolder, expireDate, cvc)
        .then((cardList) {
      this.getProfile();
      return Future.value(cardList);
    });
  }

  // Database
  // Get Token
  @override
  String getToken() {
    return mLoginDao.getToken();
  }

  // GetUserLogin
  @override
  bool isUserLogin() {
    bool isToken = false;
    isToken = getToken() != null;

    return isToken;
  }

  // User Info From Database
  @override
  Stream<UserInfoVo> getProfileFromDatabase() {
    this.
    getProfile();
    return mLoginDao
        .getUserInfoEventStream()
        .startWith(mLoginDao.getUserInfoStream())
        .map((event) => mLoginDao.getUserInfo());
  }
}
