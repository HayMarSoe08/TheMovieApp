import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:student_movie_app/data/models/lgoin_model.dart';
import 'package:student_movie_app/data/models/login_model_impl.dart';
import 'package:student_movie_app/data/models/movie_model.dart';
import 'package:student_movie_app/data/models/movie_model_impl.dart';
import 'package:student_movie_app/data/vos/cinema_vo.dart';
import 'package:student_movie_app/data/vos/movie_seat_vo.dart';
import 'package:student_movie_app/data/vos/movie_vo.dart';
import 'package:student_movie_app/dummy/dummy_data.dart';
import 'package:student_movie_app/handleError/handleError.dart';
import 'package:student_movie_app/pages/payment_method_page.dart';
import 'package:student_movie_app/resources/colors.dart';
import 'package:student_movie_app/resources/dimens.dart';
import 'package:student_movie_app/resources/strings.dart';
import 'package:student_movie_app/widgets/back_button_view.dart';
import 'package:student_movie_app/widgets/main_button_view.dart';

class MovieSeatsPage extends StatefulWidget {
  final int movieId;
  final int cinemaDayTimeSlotId;
  final String cinemaName;
  final String dateValue;
  final String selectedTime;
  final List<CinemaVo> cinemaList;

  MovieSeatsPage(this.movieId, this.cinemaDayTimeSlotId, this.cinemaName,
      this.dateValue, this.selectedTime, this.cinemaList);

  @override
  _MovieSeatsPageState createState() => _MovieSeatsPageState();
}

class _MovieSeatsPageState extends State<MovieSeatsPage> {
  List<List<MovieSeatVO>> _movieSeats;
  MovieVo _movieVo;
  MovieModel mMovieModel = new MovieModelImpl();
  LoginModel mLoginModel = new LoginModelImpl();
  int ticketCount = 0;
  String seatName = "";
  double ticketPrice = 0.00;

  HandleError handleError = new HandleError();

  @override
  void initState() {
    super.initState();

    mMovieModel
        .getMovieSeatingPlan(widget.cinemaDayTimeSlotId, widget.dateValue)
        .then((movieSeats) {
      setState(() {
        _movieSeats = movieSeats;
      });
    }).catchError((error) {
      handleError.handleError(context, error.toString());
    });

    // Database
    mMovieModel.getMovieDetailsFromDatabase(widget.movieId).listen((movie) {
      setState(() {
        this._movieVo = movie;
      });
    }).onError((error) {
      handleError.handleError(context, error.toString());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        leading: BackButtonView(() => Navigator.pop(context)),
      ),
      body: Container(
        color: Colors.white,
        child: SingleChildScrollView(
          child: Column(
            children: [
              MovieNameTimeAndCinemaSectionView(
                  movieVo: this._movieVo,
                  cinemaName: widget.cinemaName,
                  date: widget.dateValue,
                  selectedTime: widget.selectedTime),
              SizedBox(height: MARGIN_LARGE),
              MovieSeatsSectionView(
                  movieSeats: _movieSeats,
                  onTapSeat: (seatId, symbol) =>
                      setSelectedSeat(seatId, symbol)),
              SizedBox(height: MARGIN_XLARGE),
              MovieGlossarySectionView(),
              SizedBox(height: MARGIN_XLARGE),
              DottedLineSectionView(),
              SizedBox(height: MARGIN_MEDIUM_3),
              NumberOfSeatsAndTicketSectionView(
                  this.ticketCount, this.seatName),
              SizedBox(height: MARGIN_XXLARGE),
              BuyTicketButtonSectionView(
                  () => Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => PaymentMethodPage(
                              widget.movieId,
                              widget.cinemaDayTimeSlotId,
                              widget.dateValue,
                              this.seatName,
                              this.ticketPrice,
                              widget.cinemaList))),
                  this.ticketPrice),
            ],
          ),
        ),
      ),
    );
  }

  void setSelectedSeat(int seatId, String symbol) {
    setState(() {
      _movieSeats.expand((e) => e).toList().map((seat) {
        if (seat.id == seatId && seat.symbol == symbol) {
          seat.isSelected = true;
          this.ticketCount = this.ticketCount + 1;
          this.seatName = this.seatName != ""
              ? this.seatName + "," + seat.seatName
              : this.seatName + seat.seatName;
          this.ticketPrice = this.ticketPrice + seat.price;
        }
        return seat;
      }).toList();
    });
  }
}

class BuyTicketButtonSectionView extends StatelessWidget {
  final Function onTapConfirm;
  final double ticketPrice;

  BuyTicketButtonSectionView(this.onTapConfirm, this.ticketPrice);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        top: 0,
        left: MARGIN_CARD_MEDIUM_2,
        bottom: MARGIN_CARD_MEDIUM_2,
        right: MARGIN_CARD_MEDIUM_2,
      ),
      child: MainButtonView(
        this.onTapConfirm,
        "$MOVIE_SEATS_BUTTON_TEXT${this.ticketPrice}",
      ),
    );
  }
}

class NumberOfSeatsAndTicketSectionView extends StatelessWidget {
  final int ticketCount;
  final String seatName;

  NumberOfSeatsAndTicketSectionView(this.ticketCount, this.seatName);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: MARGIN_MEDIUM_2),
      child: Column(
        children: [
          NumberOfSeatsAndTicketView("Ticket", this.ticketCount.toString()),
          SizedBox(height: MARGIN_MEDIUM),
          NumberOfSeatsAndTicketView("Seats", this.seatName),
        ],
      ),
    );
  }
}

class NumberOfSeatsAndTicketView extends StatelessWidget {
  final String title;
  final String text;

  NumberOfSeatsAndTicketView(this.title, this.text);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          title,
          style: TextStyle(
            color: LOGIN_TEXT_COLOR,
            fontSize: TEXT_REGULAR_2X,
          ),
        ),
        Spacer(),
        Text(
          text ?? "",
          style: TextStyle(
            fontSize: TEXT_REGULAR_2X,
          ),
        ),
      ],
    );
  }
}

class DottedLineSectionView extends StatelessWidget {
  const DottedLineSectionView({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: MARGIN_MEDIUM_2),
      child: DottedLine(
        direction: Axis.horizontal,
        lineLength: double.infinity,
        lineThickness: 1.0,
        dashLength: MARGIN_MEDIUM,
        dashColor: LOGIN_TEXT_COLOR,
        dashGapLength: MARGIN_MEDIUM,
        dashGapColor: Colors.transparent,
        dashGapRadius: 0.0,
      ),
    );
  }
}

class MovieGlossarySectionView extends StatelessWidget {
  const MovieGlossarySectionView({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: MARGIN_MEDIUM_2),
      child: Row(
        children: [
          Expanded(
            flex: 1,
            child: MovieGlossaryView("Available", MOVIE_SEAT_AVAILABLE_COLOR),
          ),
          Expanded(
            flex: 1,
            child: MovieGlossaryView("Reserved", MOVIE_SEAT_TAKEN_COLOR),
          ),
          Expanded(
            flex: 0,
            child: MovieGlossaryView("Your Selection", PRIMARY_COLOR),
          ),
        ],
      ),
    );
  }
}

class MovieGlossaryView extends StatelessWidget {
  final String text;
  final Color color;

  MovieGlossaryView(this.text, this.color);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: MOVIE_GLOSSARY_COLOR_BOX_WIDTH,
          height: MOVIE_GLOSSARY_COLOR_BOX_WIDTH,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: color,
          ),
        ),
        SizedBox(width: MARGIN_SMALL),
        Text(
          text,
          style: TextStyle(
            fontSize: TEXT_REGULAR,
          ),
        )
      ],
    );
  }
}

class MovieSeatsSectionView extends StatelessWidget {
  final List<List<MovieSeatVO>> movieSeats;
  Function(int, String) onTapSeat;

  MovieSeatsSectionView({this.movieSeats, this.onTapSeat});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
        itemCount: movieSeats.expand((element) => element).toList().length,
        physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: movieSeats[0].length,
          childAspectRatio: 1,
        ),
        itemBuilder: (context, index) {
          return MovieSeatItemView(
              mMovieSeatVO:
                  movieSeats.expand((element) => element).toList()[index],
              onTapSeat: (seatId, symbol) => this.onTapSeat(seatId, symbol));
        });
  }
}

class MovieSeatItemView extends StatelessWidget {
  final MovieSeatVO mMovieSeatVO;
  final Function(int, String) onTapSeat;

  MovieSeatItemView({this.mMovieSeatVO, this.onTapSeat});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        this.onTapSeat(mMovieSeatVO.id, mMovieSeatVO.symbol);
      },
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 4, vertical: 4),
        decoration: BoxDecoration(
          color: _getSeatColor(mMovieSeatVO),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(MARGIN_MEDIUM),
            topRight: Radius.circular(MARGIN_MEDIUM),
          ),
        ),
        child: Center(
          child: Visibility(
            child: Text(
              _showText(mMovieSeatVO),
              style: TextStyle(
                  fontSize: (mMovieSeatVO.type != "text")
                      ? TEXT_SMALLEST
                      : TEXT_SMALL,
                  color: (mMovieSeatVO.type != "text")
                      ? Colors.white
                      : Colors.black),
            ),
            visible: (mMovieSeatVO.type == "text")
                ? true
                : mMovieSeatVO.isSelected ?? false
                    ? true
                    : false,
          ),
        ),
      ),
    );
  }
}

String _showText(MovieSeatVO movieSeat) {
  if (movieSeat.type == "text") {
    return movieSeat.symbol;
  } else if (movieSeat.type == "space") {
    return "";
  } else {
    return movieSeat.seatName;
  }
}

Color _getSeatColor(MovieSeatVO movieSeat) {
  if (movieSeat.isSelected ?? false) {
    return PRIMARY_COLOR;
  } else if (movieSeat.isMovieSeatTaken()) {
    return MOVIE_SEAT_TAKEN_COLOR;
  } else if (movieSeat.isMovieSeatAvailable()) {
    return MOVIE_SEAT_AVAILABLE_COLOR;
  } else {
    return Colors.white;
  }
}

class MovieNameTimeAndCinemaSectionView extends StatelessWidget {
  final MovieVo movieVo;
  final String cinemaName;
  final String date;
  final String selectedTime;

  MovieNameTimeAndCinemaSectionView(
      {this.movieVo, this.cinemaName, this.date, this.selectedTime});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          this.movieVo.originalTitle,
          style: TextStyle(
            color: Colors.black,
            fontSize: TEXT_REGULAR_3X,
            fontWeight: FontWeight.w700,
          ),
        ),
        SizedBox(height: MARGIN_SMALL),
        Text(
          this.cinemaName,
          style: TextStyle(
            color: Colors.black,
            fontSize: TEXT_REGULAR_2X,
          ),
        ),
        SizedBox(height: MARGIN_SMALL),
        Text(
          "${this.date}${this.selectedTime}",
          style: TextStyle(
            color: Colors.black,
            fontSize: TEXT_REGULAR_2X,
          ),
        ),
      ],
    );
  }
}
