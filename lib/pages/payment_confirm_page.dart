import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:student_movie_app/data/models/lgoin_model.dart';
import 'package:student_movie_app/data/models/login_model_impl.dart';
import 'package:student_movie_app/data/vos/cardInfo_vo.dart';
import 'package:student_movie_app/data/vos/cinema_vo.dart';
import 'package:student_movie_app/data/vos/snack_vo.dart';
import 'package:student_movie_app/data/vos/userInfo_vo.dart';
import 'package:student_movie_app/handleError/handleError.dart';
import 'package:student_movie_app/pages/add_new_card_page.dart';
import 'package:student_movie_app/pages/get_ticket_page.dart';
import 'package:student_movie_app/resources/colors.dart';
import 'package:student_movie_app/resources/dimens.dart';
import 'package:student_movie_app/resources/strings.dart';
import 'package:student_movie_app/widgets/back_button_view.dart';
import 'package:student_movie_app/widgets/main_button_view.dart';

class PaymentConfirmPage extends StatefulWidget {
  final int movieId;
  final int cinemaDayTimeSlotId;
  final String bookingDate;
  final String seatNumber;
  final double price;
  final List<SnackVo> comboSetList;
  final List<CinemaVo> cinemaList;

  PaymentConfirmPage(this.movieId, this.cinemaDayTimeSlotId, this.bookingDate,
      this.seatNumber, this.price, this.comboSetList, this.cinemaList);

  @override
  _PaymentConfirmPageState createState() => _PaymentConfirmPageState();
}

class _PaymentConfirmPageState extends State<PaymentConfirmPage> {
  LoginModel mLoginModel = new LoginModelImpl();
  UserInfoVo userInfo;
  HandleError handleError = new HandleError();

  int selectedCardId;

  @override
  void initState() {
    super.initState();

    /// User Profile From Database
    mLoginModel.getProfileFromDatabase().listen((userProfile) {
      setState(() {
        userInfo = userProfile;
      });
    }).onError((error) {
      handleError.handleError(context, error.toString());
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    /// User Profile From Database
    mLoginModel.getProfileFromDatabase().listen((userProfile) {
      setState(() {
        userInfo = userProfile;
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
          color: LOGIN_PAGE_BACKGROUND_COLOR,
          height: MediaQuery.of(context).size.height,
          child: PaymentConfirmView(
              widget.price,
              this.userInfo,
              () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => GetTicketPage(
                          widget.movieId,
                          widget.cinemaDayTimeSlotId,
                          widget.bookingDate,
                          widget.seatNumber,
                          widget.price,
                          widget.comboSetList,
                          this.selectedCardId,
                          widget.cinemaList),
                    ),
                  ),
              () => addNewCardPage(),
              (id) => this.selectedCardId = id),
        ),
      ),
    );
  }

  void addNewCardPage() {
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return AddNewCardPage();
    }));
  }
}

class PaymentConfirmView extends StatelessWidget {
  final double price;
  final UserInfoVo userInfo;
  final Function onTapConfirm;
  final Function onTapAddNewCard;
  final Function(int) onTapCard;

  PaymentConfirmView(this.price, this.userInfo, this.onTapConfirm,
      this.onTapAddNewCard, this.onTapCard);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(
            top: MARGIN_XLARGE,
            left: 0,
            bottom: 0,
            right: 0,
          ),
          child: BackButtonView(
            () => Navigator.pop(context),
          ),
        ),
        SizedBox(height: MARGIN_MEDIUM_2),
        PaymentAmountSectionView(this.price),
        SizedBox(height: MARGIN_MEDIUM_2),
        PaymentCardSectionView(
            cardInfo: userInfo?.cards, onTapCard: (id) => onTapCard(id)),
        SizedBox(height: MARGIN_LARGE),
        AddNewCardSectionView(onTapAddNewCard: onTapAddNewCard),
        SizedBox(height: MARGIN_XXLARGE),
        ConfirmButtonSectionView(onTapConfirm: onTapConfirm),
      ],
    );
  }
}

class ConfirmButtonSectionView extends StatelessWidget {
  const ConfirmButtonSectionView({
    Key key,
    @required this.onTapConfirm,
  }) : super(key: key);

  final Function onTapConfirm;

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
        LOGIN_SCREEN_CONFIRM_BUTTON_TEXT,
      ),
    );
  }
}

class AddNewCardSectionView extends StatelessWidget {
  const AddNewCardSectionView({
    Key key,
    @required this.onTapAddNewCard,
  }) : super(key: key);

  final Function onTapAddNewCard;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: MARGIN_CARD_MEDIUM_2),
      child: Container(
        child: GestureDetector(
          onTap: () {
            onTapAddNewCard();
          },
          child: Row(
            children: [
              Icon(
                Icons.add_circle_outline_outlined,
                size: MARGIN_LARGE,
                color: PAYMENT_AMOUNT_TEXT_COLOR,
              ),
              SizedBox(width: MARGIN_CARD_MEDIUM_2),
              Text(
                ADD_NEW_CARD_BUTTON_TEXT,
                style: TextStyle(
                  fontSize: TEXT_REGULAR_3X,
                  color: PAYMENT_AMOUNT_TEXT_COLOR,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class PaymentCardSectionView extends StatelessWidget {
  final List<CardInfoVo> cardInfo;
  final Function(int) onTapCard;

  PaymentCardSectionView({this.cardInfo, this.onTapCard});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: PAYMENT_CONFIRM_CREDIT_CARD_HEIGHT,
      child: (this.cardInfo != null)
          ? CarouselSlider(
              options: CarouselOptions(),
              items: this
                  .cardInfo
                  .map(
                    (card) => Container(
                      color: Colors.yellow,
                      margin: EdgeInsets.symmetric(horizontal: MARGIN_MEDIUM),
                      padding: EdgeInsets.symmetric(horizontal: MARGIN_LARGE),
                      width: PAYMENT_CONFIRM_CREDIT_CARD_WIDTH,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            CREDIT_CARD_START_COLOR,
                            Colors.deepPurple,
                          ],
                        ),
                        borderRadius: BorderRadius.circular(MARGIN_MEDIUM),
                      ),
                      child: GestureDetector(
                        onTap: () {
                          onTapCard(card.id);
                        },
                        child: Column(
                          children: [
                            SizedBox(height: MARGIN_MEDIUM_3),
                            Row(
                              children: [
                                Text(
                                  card.cardType,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: TEXT_REGULAR_3X,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Spacer(),
                                Text(
                                  "...",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: TEXT_REGULAR_3X,
                                    fontWeight: FontWeight.w600,
                                  ),
                                )
                              ],
                            ),
                            SizedBox(height: MARGIN_XXLARGE),
                            Row(
                              children: [
                                Text(
                                  card.cardNumber.substring(0, 4),
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: TEXT_REGULAR_3X,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                                Spacer(),
                                Text(
                                  card.cardNumber.substring(4, 8),
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: TEXT_REGULAR_3X,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                                Spacer(),
                                Text(
                                  card.cardNumber.substring(8),
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: TEXT_REGULAR_3X,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: MARGIN_XLARGE),
                            Row(
                              children: [
                                Text(
                                  "CARD HOLDER",
                                  style: TextStyle(
                                    color: LOGIN_TEXT_COLOR,
                                    fontSize: TEXT_REGULAR_2X,
                                  ),
                                ),
                                Spacer(),
                                Text(
                                  "EXPIRES",
                                  style: TextStyle(
                                    color: LOGIN_TEXT_COLOR,
                                    fontSize: TEXT_REGULAR_2X,
                                  ),
                                )
                              ],
                            ),
                            SizedBox(height: MARGIN_SMALL),
                            Row(
                              children: [
                                Text(
                                  card.cardHolder,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: TEXT_REGULAR_3X,
                                  ),
                                ),
                                Spacer(),
                                Text(
                                  card.expirationDate,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: TEXT_REGULAR_3X,
                                  ),
                                )
                              ],
                            ),
                            SizedBox(height: MARGIN_SMALL),
                          ],
                        ),
                      ),
                    ),
                  )
                  .toList(),
            )
          : Container(),
    );
  }
}

class PaymentAmountSectionView extends StatelessWidget {
  final double price;

  PaymentAmountSectionView(this.price);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: MARGIN_CARD_MEDIUM_2),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Payment amount",
            style: TextStyle(
              fontSize: TEXT_REGULAR_2X,
              fontWeight: FontWeight.w400,
              color: LOGIN_TEXT_COLOR,
            ),
          ),
          SizedBox(height: MARGIN_MEDIUM),
          Text(
            "\$ ${this.price}",
            style: TextStyle(
              fontSize: TEXT_HEADING_1X,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
