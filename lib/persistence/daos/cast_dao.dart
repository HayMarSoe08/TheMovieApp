import 'package:hive_flutter/hive_flutter.dart';
import 'package:student_movie_app/data/vos/cast_vo.dart';

import '../hive_constants.dart';

class CastDao {
  static final CastDao _singleton = CastDao._internal();

  factory CastDao() {
    return _singleton;
  }

  CastDao._internal();

  void saveAllCasts(List<CastVo> castList) async {
    Map<int, CastVo> castMap = Map.fromIterable(castList,
        key: (cast) => cast.id, value: (cast) => cast);
    await getCastBox().putAll(castMap);
  }

  // List<CastVo> getAllCasts(){
  //   return getCastBox().values.toList();
  // }

  /// Reactive Programming
  Stream<void> getAllCastsEventStream() {
    return getCastBox().watch();
  }

  Stream<List<CastVo>> getAllCastsStream(){
    return Stream.value(getCastBox().values.toList());
  }

  List<CastVo> getAllCasts(){
    return getCastBox().values.toList();
  }

  Box<CastVo> getCastBox() {
    return Hive.box<CastVo>(BOX_NAME_CAST_VO);
  }
}