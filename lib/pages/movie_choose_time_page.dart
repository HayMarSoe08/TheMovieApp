import 'package:flutter/material.dart';
import 'package:student_movie_app/data/models/lgoin_model.dart';
import 'package:student_movie_app/data/models/login_model_impl.dart';
import 'package:student_movie_app/data/models/movie_model.dart';
import 'package:student_movie_app/data/models/movie_model_impl.dart';
import 'package:student_movie_app/data/vos/cinema_vo.dart';
import 'package:student_movie_app/dummy/dummy_date.dart';
import 'package:student_movie_app/dummy/dummy_day.dart';
import 'package:student_movie_app/handleError/handleError.dart';
import 'package:student_movie_app/pages/movie_seats_page.dart';
import 'package:student_movie_app/resources/colors.dart';
import 'package:student_movie_app/resources/dimens.dart';
import 'package:student_movie_app/resources/strings.dart';
import 'package:student_movie_app/widgets/back_button_view.dart';
import 'package:student_movie_app/widgets/main_button_view.dart';

class MovieChooseTimePage extends StatefulWidget {
  final int movieId;

  MovieChooseTimePage(this.movieId);

  @override
  _MovieChooseTimePageState createState() => _MovieChooseTimePageState();
}

class _MovieChooseTimePageState extends State<MovieChooseTimePage> {
  MovieModel mMovieModel = new MovieModelImpl();
  LoginModel mLoginModel = new LoginModelImpl();
  List<CinemaVo> cinemaList = [];
  HandleError handleError = new HandleError();

  int cinemaDayTimeSlotId;
  String cinemaName;
  int dateIndex;
  String selectedTime;

  @override
  void initState() {
    super.initState();

    getCinemaDayTimeslot(0, dummyDate[0].date);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: PRIMARY_COLOR,
        leading: BackButtonView(() => Navigator.pop(context)),
      ),
      body: Container(
        child: SingleChildScrollView(
          child: Column(
            children: [
              MovieChooseDateView(
                (dateIndex, dateValue) =>
                    getCinemaDayTimeslot(dateIndex, dateValue),
              ),
              ChooseItemGridSectionView(
                this.cinemaList,
                onTapTimeslot: (cinemaId, timeslotId, isSelect) =>
                    setSelectedTimeslot(cinemaId, timeslotId),
              ),
              SizedBox(height: MARGIN_LARGE),
              ButtonSectionView(
                () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MovieSeatsPage(
                        widget.movieId,
                        this.cinemaDayTimeSlotId,
                        this.cinemaName,
                        dummyDate[this.dateIndex].date,
                    this.selectedTime,
                    this.cinemaList),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void getCinemaDayTimeslot(int dateIndex, String dateValue) {
    setState(() {
      this.dateIndex = dateIndex;
        mMovieModel
            .getCinemaDayTimeslotFromDatabase(dummyDate[dateIndex].date)
            .listen((cinema) {
          setState(() {
            cinemaList = cinema;
          });
        }).onError((error) {
          handleError.handleError(context, error.toString());
      });

      dummyDate.map((date) {
        date.isSelected = false;
        return date;
      }).map((date) {
        if (date.date == dateValue) {
          date.isSelected = true;
        }
        return date;
      }).toList();
    });
  }

  void setSelectedTimeslot(int cinemaId, int timeslotId) {
    setState(() {
      cinemaDayTimeSlotId = timeslotId;
      cinemaName = cinemaList
          .where((cinema) => cinema.cinemaId == cinemaId)
          .first
          .cinema;
      cinemaList
          .where((cinema) => cinema.cinemaId == cinemaId)
          .first
          .timeslots
          .map((timeslot) {
        timeslot.isSelected = false;
        return timeslot;
      }).map((timeslot) {
        if (timeslot.cinemaDayTimeslotId == timeslotId) {
          timeslot.isSelected = true;
          selectedTime = timeslot.startTime;
        }
        return timeslot;
      }).toList();
    });
  }
}

class ButtonSectionView extends StatelessWidget {
  final Function onTapConfirm;

  ButtonSectionView(this.onTapConfirm);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        top: 0,
        left: MARGIN_CARD_MEDIUM_2,
        bottom: MARGIN_CARD_MEDIUM_2,
        right: MARGIN_CARD_MEDIUM_2,
      ),
      child: MainButtonView(this.onTapConfirm, CHOOSE_MOVIE_BUTTON_TEXT),
    );
  }
}

class ChooseItemGridSectionView extends StatelessWidget {
  final List<CinemaVo> cinemaList;
  final Function(int, int, bool) onTapTimeslot;

  ChooseItemGridSectionView(this.cinemaList, {this.onTapTimeslot});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.7,
      padding: EdgeInsets.only(
        top: MARGIN_MEDIUM_2,
        left: MARGIN_MEDIUM_2,
        right: MARGIN_MEDIUM_2,
      ),
      color: Colors.white,
      child: (cinemaList != null)
          ? ListView.builder(
              itemCount: cinemaList.length,
              itemBuilder: (BuildContext context, int index) =>
                  ChooseItemGridView(
                mCinema: cinemaList[index],
                onTapTimeslot: (cinemaId, timeslotId, isSelect) =>
                    onTapTimeslot(cinemaId, timeslotId, isSelect),
              ),
            )
          : CircularProgressIndicator(),
    );
  }
}

class ChooseItemGridView extends StatelessWidget {
  final CinemaVo mCinema;
  final Function(int, int, bool) onTapTimeslot;

  ChooseItemGridView({this.mCinema, this.onTapTimeslot});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: MARGIN_MEDIUM_2),
        Text(
          mCinema.cinema,
          style: TextStyle(
            color: Colors.black,
            fontSize: TEXT_REGULAR_3X,
            fontWeight: FontWeight.w700,
          ),
        ),
        SizedBox(height: MARGIN_MEDIUM),
        GridView.builder(
          physics: NeverScrollableScrollPhysics(),
          itemCount: mCinema.timeslots.length,
          shrinkWrap: true,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            childAspectRatio: 2.2,
          ),
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                this.onTapTimeslot(
                    mCinema.cinemaId,
                    mCinema.timeslots[index].cinemaDayTimeslotId,
                    mCinema.timeslots[index].isSelected);
              },
              child: Container(
                margin: EdgeInsets.only(
                  left: MARGIN_MEDIUM_2,
                  top: MARGIN_MEDIUM_2,
                  right: MARGIN_MEDIUM,
                ),
                decoration: BoxDecoration(
                  color: mCinema.timeslots[index].isSelected ?? false
                      ? PRIMARY_COLOR
                      : LOGIN_PAGE_BACKGROUND_COLOR,
                  border: Border.all(
                    color: LOGIN_TEXT_COLOR,
                    width: 1,
                  ),
                  borderRadius: BorderRadius.circular(
                    MARGIN_MEDIUM,
                  ),
                ),
                child: Center(
                  child: Text(
                    mCinema.timeslots[index].startTime,
                  ),
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}

class MovieChooseDateView extends StatelessWidget {
  final Function(int, String) onTapDate;

  MovieChooseDateView(this.onTapDate);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: PRIMARY_COLOR,
      height: MOVIE_ITEM_DATE_LIST_HEIGHT,
      child: ListView.separated(
        padding: EdgeInsets.symmetric(horizontal: MARGIN_MEDIUM_2),
        separatorBuilder: (context, index) {
          return SizedBox(width: MARGIN_MEDIUM_2);
        },
        scrollDirection: Axis.horizontal,
        itemCount: 7,
        itemBuilder: (context, index) {
          return Column(
            children: [
              GestureDetector(
                onTap: () {
                  onTapDate(index, dummyDate[index].date);
                },
                child: Container(
                    color: PRIMARY_COLOR,
                    child: Column(
                      children: [
                        Text(
                          dummyDay[index],
                          style: TextStyle(
                            color: dummyDate[index].isSelected ?? false
                                ? Colors.white
                                : Colors.grey,
                            fontSize: TEXT_REGULAR_3X,
                          ),
                        ),
                        SizedBox(height: MARGIN_MEDIUM),
                        Text(
                          dummyDate[index].date.substring(8),
                          style: TextStyle(
                            color: dummyDate[index].isSelected ?? false
                                ? Colors.white
                                : Colors.grey,
                            fontSize: TEXT_REGULAR_3X,
                          ),
                        ),
                      ],
                    )),
              ),
            ],
          );
        },
      ),
    );
  }
}
