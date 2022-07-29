import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:student_movie_app/data/models/movie_model.dart';
import 'package:student_movie_app/data/models/movie_model_impl.dart';
import 'package:student_movie_app/data/vos/checkout_vo.dart';
import 'package:student_movie_app/data/vos/cinema_vo.dart';
import 'package:student_movie_app/data/vos/movie_vo.dart';
import 'package:student_movie_app/data/vos/snack_vo.dart';
import 'package:student_movie_app/handleError/handleError.dart';
import 'package:student_movie_app/network/api_constants.dart';
import 'package:student_movie_app/pages/movie_detail_page.dart';
import 'package:student_movie_app/resources/colors.dart';
import 'package:student_movie_app/resources/dimens.dart';
import 'package:barcode_flutter/barcode_flutter.dart';

import 'movie_home_page.dart';

class GetTicketPage extends StatefulWidget {
  final int movieId;
  final int cinemaDayTimeSlotId;
  final String bookingDate;
  final String seatNumber;
  final double price;
  final List<SnackVo> comboSetList;
  final int cardId;
  final List<CinemaVo> cinemaList;

  GetTicketPage(
      this.movieId,
      this.cinemaDayTimeSlotId,
      this.bookingDate,
      this.seatNumber,
      this.price,
      this.comboSetList,
      this.cardId,
      this.cinemaList);

  @override
  _GetTicketPageState createState() => _GetTicketPageState();
}

class _GetTicketPageState extends State<GetTicketPage> {
  MovieModel mMovieModel = new MovieModelImpl();
  MovieVo _movieVo;
  CheckOutVo _checkOutData;

  HandleError handleError = new HandleError();

  @override
  void initState() {
    super.initState();

    mMovieModel
        .postCheckOut(
            widget.cinemaDayTimeSlotId,
            widget.seatNumber,
            widget.bookingDate,
            widget.movieId,
            widget.cardId,
            widget.comboSetList)
        .then((checkOut) {
      setState(() {
        this._checkOutData = checkOut;
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
      body: SingleChildScrollView(
        child: Container(
          color: GET_TICKET_BACKGROUND_COLOR,
          padding: EdgeInsets.symmetric(horizontal: MARGIN_CARD_MEDIUM_2),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(top: MARGIN_XLARGE),
                child: GestureDetector(
                  onTap: () {
                    Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                MovieHomePage()),
                        (Route<dynamic> route) => false);
                  },
                  child: Icon(
                    Icons.close,
                  ),
                ),
              ),
              SizedBox(height: MARGIN_MEDIUM),
              TicketTitleSectionView(),
              SizedBox(height: MARGIN_MEDIUM),
              TicketDetailSectionView(
                  movieVo: this._movieVo,
                  checkOutData: this._checkOutData,
                  cinemaList: widget.cinemaList),
            ],
          ),
        ),
      ),
    );
  }
}

class TicketDetailSectionView extends StatelessWidget {
  final MovieVo movieVo;
  final CheckOutVo checkOutData;
  final List<CinemaVo> cinemaList;

  TicketDetailSectionView({this.movieVo, this.checkOutData, this.cinemaList});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          TicketMovieImageView(movieVo: this.movieVo),
          BoxDecorationView(),
          TicketInfoDetailView(
              checkOutData: this.checkOutData, cinemaList: this.cinemaList),
          BoxDecorationView(),
          TicketBarCodeView(),
        ],
      ),
    );
  }
}

class TicketTitleSectionView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Center(
            child: Text(
              "Awesome!",
              style: TextStyle(
                fontSize: TEXT_HEADING_1X,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          SizedBox(height: MARGIN_SMALL),
          Center(
            child: Text(
              "This is your ticket.",
              style: TextStyle(
                fontSize: TEXT_REGULAR_2X,
                color: LOGIN_TEXT_COLOR,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class TicketBarCodeView extends StatelessWidget {
  const TicketBarCodeView({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: TICKET_HEIGHT_FOR_QR_CODE,
      width: TICKET_WIDTH,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(TICKET_BOX_RADIUS),
            bottomRight: Radius.circular(TICKET_BOX_RADIUS)),
      ),
      child: Container(
        margin: EdgeInsets.only(bottom: MARGIN_MEDIUM),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: EdgeInsets.symmetric(vertical: MARGIN_MEDIUM),
              child: BarCodeImage(
                params: Code39BarCodeParams(
                  "1121938",
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class TicketInfoDetailView extends StatelessWidget {
  final CheckOutVo checkOutData;

  final List<CinemaVo> cinemaList;

  TicketInfoDetailView({this.checkOutData, this.cinemaList});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: TICKET_HEIGHT,
      width: TICKET_WIDTH,
      color: Colors.white,
      padding: const EdgeInsets.symmetric(horizontal: MARGIN_MEDIUM_2),
      child: Column(
        children: [
          TicketInfoView("Booking no", this.checkOutData.bookingNo),
          SizedBox(height: MARGIN_MEDIUM_2),
          TicketInfoView("Show Time - Date", this.checkOutData.bookingDate),
          SizedBox(height: MARGIN_MEDIUM_2),
          TicketInfoView(
              "Theater",
              cinemaList
                  .map((e) => e)
                  .where((element) =>
                      element.cinemaId == this.checkOutData.cinemaId)
                  .first
                  .cinema),
          SizedBox(height: MARGIN_MEDIUM_2),
          TicketInfoView("Screen", this.checkOutData.seat),
          SizedBox(height: MARGIN_MEDIUM_2),
          TicketInfoView("Row", this.checkOutData.row),
          SizedBox(height: MARGIN_MEDIUM_2),
          Row(
            children: [
              Column(
                children: [
                  Text(
                    "Seat",
                    style: TextStyle(
                      color: LOGIN_TEXT_COLOR,
                      fontSize: TEXT_REGULAR_X,
                    ),
                  ),
                  SizedBox(height: MARGIN_SMALL),
                  Text(
                    "s",
                    style: TextStyle(
                      color: LOGIN_TEXT_COLOR,
                      fontSize: TEXT_REGULAR_X,
                    ),
                  ),
                ],
              ),
              Spacer(),
              Text(
                this.checkOutData.seat,
                style: TextStyle(
                  fontSize: TEXT_REGULAR_X,
                ),
              )
            ],
          ),
          SizedBox(height: MARGIN_MEDIUM_2),
          TicketInfoView(
              "Price", "\$${this.checkOutData.snacks[0].totalPrice}"),
        ],
      ),
    );
  }
}

class TicketInfoView extends StatelessWidget {
  final String textTitle;
  final String textVale;

  TicketInfoView(this.textTitle, this.textVale);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          textTitle,
          style: TextStyle(
            color: LOGIN_TEXT_COLOR,
            fontSize: TEXT_REGULAR_X,
          ),
        ),
        Spacer(),
        Text(
          textVale,
          style: TextStyle(
            fontSize: TEXT_REGULAR_X,
          ),
        )
      ],
    );
  }
}

class TicketMovieImageView extends StatelessWidget {
  final MovieVo movieVo;

  TicketMovieImageView({this.movieVo});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: TICKET_HEIGHT,
      width: TICKET_WIDTH,
      margin: EdgeInsets.symmetric(horizontal: MARGIN_CARD_MEDIUM_2),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(TICKET_BOX_RADIUS),
            topRight: Radius.circular(TICKET_BOX_RADIUS)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(TICKET_BOX_RADIUS),
                topRight: Radius.circular(TICKET_BOX_RADIUS)),
            child: Image.network(
              "$IMAGE_BASE_URL${movieVo?.posterPath}",
              fit: BoxFit.cover,
              height: TICKET_IMAGE_HEIGHT,
              width: TICKET_WIDTH,
            ),
          ),
          SizedBox(height: MARGIN_SMALL),
          Padding(
            padding: const EdgeInsets.only(left: MARGIN_MEDIUM_2),
            child: Text(
              movieVo.originalTitle,
              style: TextStyle(
                fontSize: TEXT_REGULAR_2X,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: MARGIN_MEDIUM_2),
            child: Text(
              "${movieVo.runtime} - IMAX",
              style: TextStyle(
                fontSize: TEXT_REGULAR_X,
                color: LOGIN_TEXT_COLOR,
              ),
            ),
          )
        ],
      ),
    );
  }
}

class BoxDecorationView extends StatelessWidget {
  const BoxDecorationView({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      width: TICKET_WIDTH,
      child: Row(
        children: [
          SizedBox(
            height: TICKET_SIZED_BOX_HEIGHT,
            width: TICKET_SIZED_BOX_WIDTH,
            child: DecoratedBox(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(TICKET_BOX_RADIUS),
                    bottomRight: Radius.circular(TICKET_BOX_RADIUS)),
                color: Colors.grey.shade200,
              ),
            ),
          ),
          Expanded(
            child: LayoutBuilder(
              builder: (context, constraint) {
                return Flex(
                  children: List.generate(
                    (constraint.constrainWidth() / 10).floor(),
                    (index) => SizedBox(
                      height: TICKET_FLEX_SIZED_BOX_HEIGHT,
                      width: TICKET_FLEX_SIZED_BOX_WIDTH,
                      child: DecoratedBox(
                        decoration: BoxDecoration(color: Colors.grey.shade500),
                      ),
                    ),
                  ),
                  direction: Axis.horizontal,
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                );
              },
            ),
          ),
          SizedBox(
            height: TICKET_SIZED_BOX_HEIGHT,
            width: TICKET_SIZED_BOX_WIDTH,
            child: DecoratedBox(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(TICKET_BOX_RADIUS),
                    bottomLeft: Radius.circular(TICKET_BOX_RADIUS)),
                color: Colors.grey.shade200,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
