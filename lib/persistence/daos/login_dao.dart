import 'package:hive/hive.dart';
import 'package:student_movie_app/data/vos/userInfo_vo.dart';
import 'package:student_movie_app/network/responses/post_login_response.dart';
import 'package:student_movie_app/persistence/hive_constants.dart';

class LoginDao {
  static final LoginDao _singleton = LoginDao._internal();

  factory LoginDao() {
    return _singleton;
  }

  LoginDao._internal();

  /// UserInfo
  void saveUserInfo(UserInfoVo userVo) async {
    await getUserInfoBox().put(0, userVo);
  }

  /// Reactive Programming
  Stream<void> getUserInfoEventStream() {
    return getUserInfoBox().watch();
  }

  Stream<UserInfoVo> getUserInfoStream() {
    return Stream.value(getUserInfoBox().values.first);
  }

  UserInfoVo getUserInfo() {
    return getUserInfoBox().values.first;
  }

  Box<UserInfoVo> getUserInfoBox() {
    return Hive.box<UserInfoVo>(BOX_NAME_USERINFO_VO);
  }

  /// Token
  void saveToken(String token) async {
    await getTokenBox().put(0, token);
  }

  String getToken() {
    return getTokenBox().get(0);
  }

  void deleteToken() async {
    getTokenBox().clear();
  }

  Box<String> getTokenBox() {
    return Hive.box<String>(BOX_NAME_TOKEN_VO);
  }
}
