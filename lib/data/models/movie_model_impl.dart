import 'package:student_movie_app/data/models/lgoin_model.dart';
import 'package:student_movie_app/data/models/login_model_impl.dart';
import 'package:student_movie_app/data/models/movie_model.dart';
import 'package:student_movie_app/data/vos/cast_vo.dart';
import 'package:student_movie_app/data/vos/checkout_vo.dart';
import 'package:student_movie_app/data/vos/cinema_vo.dart';
import 'package:student_movie_app/data/vos/movie_seat_vo.dart';
import 'package:student_movie_app/data/vos/movie_vo.dart';
import 'package:student_movie_app/data/vos/snack_vo.dart';
import 'package:student_movie_app/network/dataagents/movie_data_agent.dart';
import 'package:student_movie_app/network/dataagents/retrofit_data_agent_impl.dart';
import 'package:student_movie_app/network/request/checkout_request.dart';
import 'package:student_movie_app/network/request/snack_request.dart';
import 'package:student_movie_app/persistence/daos/cast_dao.dart';
import 'package:student_movie_app/persistence/daos/cinema_dao.dart';
import 'package:student_movie_app/persistence/daos/movie_dao.dart';
import 'package:stream_transform/stream_transform.dart';
import 'package:student_movie_app/persistence/daos/snack_dao.dart';

class MovieModelImpl extends MovieModel {
  MovieDataAgent mDataAgent = RetrofitDataAgentImpl();
  MovieDao mMovieDao = new MovieDao();
  CastDao mCastDao = new CastDao();
  CinemaDao mCinemaDao = new CinemaDao();
  SnackDao mSnackDao = new SnackDao();
  LoginModel mLoginModel = new LoginModelImpl();

  static final MovieModelImpl _singleton = MovieModelImpl._internal();

  factory MovieModelImpl() {
    return _singleton;
  }

  MovieModelImpl._internal();

  // Network
  // Get Movie List
  @override
  void getMovieList(String status) {
    mDataAgent.getMovieList(status).then((movies) {
      List<MovieVo> isNowPlayingMovies = movies.map((movies) {
        status == "nowPlaying"
            ? movies.isNowPlaying = true
            : movies.isComingsoon = true;
        return movies;
      }).toList();
      mMovieDao.saveMovieAll(isNowPlayingMovies);
      //return Future.value(movies);
    });
  }

  // Get Movie Details
  @override
  void getMovieDetails(int movieId) {
    Future<MovieVo> movie = mDataAgent.getMovieDetails(movieId);
    movie.then((movie) => mMovieDao.saveSingleMovie(movie));
    movie.then((movie) => mCastDao
        .saveAllCasts(movie.casts.where((cast) => cast.isActor()).toList()));
    //return Future.value(movie);
  }

  // Get Cinema Day Timeslots
  @override
  void getCinemaDayTimeslot(String date) {
    String token;
    token = mLoginModel.getToken();
    List<CinemaVo> cinemaList;
    mDataAgent.getCinemaDayTimeslot(token, date).then((value) {
      cinemaList = value;
      mCinemaDao.saveCinemas(cinemaList, date);
    });
  }

  // Get Movie Seating Plan
  @override
  Future<List<List<MovieSeatVO>>> getMovieSeatingPlan(
      int cinemaDayTimeslotId, String bookingDate) {
    String token;
    token = mLoginModel.getToken();
    return Future.value(mDataAgent.getMovieSeatingPlan(
        token, cinemaDayTimeslotId, bookingDate));
  }

  // Get Snack List
  @override
  void getSnackList() {
    String token;
    token = mLoginModel.getToken();

    mDataAgent
        .getSnackList(token)
        .then((snackList) => mSnackDao.SaveAllSnackList(snackList));
  }

  // User Transaction
  @override
  Future<CheckOutVo> getUserTransaction() {
    String token;
    token = mLoginModel.getToken();
    return Future.value(mDataAgent.getUserTransaction(token));
  }

  // CheckOut
  @override
  Future<CheckOutVo> postCheckOut(int cinemaDayTimeSlotId, String seatNumber,
      String bookingDate, int movieId, int cardId, List<SnackVo> snackList) {
    CheckOutRequest checkOutRequest = new CheckOutRequest(
        cinemaDayTimeSlotId,
        seatNumber,
        bookingDate,
        movieId,
        cardId,
        snackList
            .map((snack) => new SnackRequest(snack.id, snack.quantity))
            .toList());
    String token;
    token = mLoginModel.getToken();

    return Future.value(mDataAgent.postCheckOut(token, checkOutRequest));
  }

  // Database
  // Now Playing
  @override
  Stream<List<MovieVo>> getNowPlayingMovieListFromDatabase() {
    this.getMovieList("nowPlaying");
    return mMovieDao
        .getAllMoviesEventStream()
        .startWith(mMovieDao.getNowPlayingMoviesStream())
        .map((event) => mMovieDao.getNowPlayingMovies());
  }

  // Coming Soon
  @override
  Stream<List<MovieVo>> getComingSoonMovieListFromDatabase() {
    this.getMovieList("comingsoon");
    return mMovieDao
        .getAllMoviesEventStream()
        .startWith(mMovieDao.getComingSoonMoviesStream())
        .map((event) => mMovieDao.getComingSoonMovies());
  }

  // Movie Details From Database
  @override
  Stream<MovieVo> getMovieDetailsFromDatabase(int movieId) {
    this.getMovieDetails(movieId);
    return mMovieDao
        .getAllMoviesEventStream()
        .startWith(mMovieDao.getMovieDetailsStream(movieId))
        .map((event) => mMovieDao.getMovieDetails(movieId));
  }

  // Cast From Database
  @override
  Stream<List<CastVo>> getAllCastFromDatabase() {
    return mCastDao
        .getAllCastsEventStream()
        .startWith(mCastDao.getAllCastsStream())
        .map((event) => mCastDao.getAllCasts());
  }

  // CinemaDayTimeslot From Database
  @override
  Stream<List<CinemaVo>> getCinemaDayTimeslotFromDatabase(String date) {
    this.getCinemaDayTimeslot(date);
    return mCinemaDao
        .getAllCinemaEventStream()
        .startWith(mCinemaDao.getAllCinemaStream(date))
        .map((event) => mCinemaDao.getAllCinemaByDate(date));
  }

  // SnackList From Database
  @override
  Stream<List<SnackVo>> getSnackListFromDatabase() {
    this.getSnackList();
    return mSnackDao
        .getAllSnackEventStream()
        .startWith(mSnackDao.getAllSnackListStream())
        .map((event) => mSnackDao.getAllSnackList());
  }
}
