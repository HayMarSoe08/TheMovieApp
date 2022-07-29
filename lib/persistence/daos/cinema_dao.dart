import 'package:hive_flutter/hive_flutter.dart';
import 'package:student_movie_app/data/vos/cinema_vo.dart';
import 'package:student_movie_app/persistence/hive_constants.dart';

class CinemaDao {
  static final CinemaDao _singleton = CinemaDao._internal();

  factory CinemaDao() {
    return _singleton;
  }

  CinemaDao._internal();

  void saveCinemas(List<CinemaVo> cinemaList, String date) async {
    List<CinemaVo> updatedCinemaList = cinemaList.map((cinema) {
      CinemaVo cinemaFromHive = this.getCinemaById(cinema.cinemaId);

      if (cinemaFromHive == null) {
        cinema.dates = [];
        cinema.dates.add(date);
        return cinema;
      } else {
        cinemaFromHive.dates.add(date);
        return cinemaFromHive;
      }
    }).toList();

    Map<int, CinemaVo> cinemaMap = Map.fromIterable(updatedCinemaList,
        key: (cinema) => cinema.cinemaId, value: (cinema) => cinema);

    await getCinemaBox().putAll(cinemaMap);
  }

  CinemaVo getCinemaById(int cinemaId) {
    return getCinemaBox().get(cinemaId);
  }

  /// Reactive Programming
  Stream<void> getAllCinemaEventStream() {
    return getCinemaBox().watch();
  }

  Stream<List<CinemaVo>> getAllCinemaStream(String date) {
    return Stream.value(getAllCinemas()
        .where((cinema) => cinema?.dates?.contains(date))
        .toList());
  }

  List<CinemaVo> getAllCinemaByDate(String date) {
    if (getAllCinemas() != null && (getAllCinemas().isNotEmpty ?? false)) {
      return getAllCinemas()
          .where((cinema) => cinema?.dates?.contains(date))
          .toList();
    } else {
      return [];
    }
  }

  List<CinemaVo> getAllCinemas() {
    return getCinemaBox().values.toList();
  }

  Box<CinemaVo> getCinemaBox() {
    return Hive.box<CinemaVo>(BOX_NAME_CINEMA_VO);
  }
}
