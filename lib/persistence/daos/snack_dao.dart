import 'package:hive_flutter/hive_flutter.dart';
import 'package:student_movie_app/data/vos/snack_vo.dart';

import '../hive_constants.dart';

class SnackDao {
  static final SnackDao _singleton = SnackDao._internal();

  factory SnackDao() {
    return _singleton;
  }

  SnackDao._internal();

  void SaveAllSnackList(List<SnackVo> snackList) async {
    Map<int, SnackVo> snackMap = Map.fromIterable(snackList,
        key: (snack) => snack.id, value: (snack) => snack);

    await getBoxSnack().putAll(snackMap);
  }

  /// Reactive Programming
  Stream<void> getAllSnackEventStream() {
    return getBoxSnack().watch();
  }

  Stream<List<SnackVo>> getAllSnackListStream() {
    return Stream.value(getBoxSnack().values.toList());
  }

  List<SnackVo> getAllSnackList() {
    return getBoxSnack().values.toList();
  }

  Box<SnackVo> getBoxSnack() {
    return Hive.box<SnackVo>(BOX_NAME_SNACK_VO);
  }
}
