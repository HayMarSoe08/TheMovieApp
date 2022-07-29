import 'package:flutter/material.dart';
import 'package:flutter_spinbox/flutter_spinbox.dart';
import 'package:student_movie_app/data/models/lgoin_model.dart';
import 'package:student_movie_app/data/models/login_model_impl.dart';
import 'package:student_movie_app/data/models/movie_model.dart';
import 'package:student_movie_app/data/models/movie_model_impl.dart';
import 'package:student_movie_app/data/vos/cinema_vo.dart';
import 'package:student_movie_app/data/vos/snack_vo.dart';
import 'package:student_movie_app/handleError/handleError.dart';
import 'package:student_movie_app/pages/payment_confirm_page.dart';
import 'package:student_movie_app/resources/colors.dart';
import 'package:student_movie_app/resources/dimens.dart';
import 'package:student_movie_app/widgets/back_button_view.dart';
import 'package:student_movie_app/widgets/main_button_view.dart';

class PaymentMethodPage extends StatefulWidget {
  final int movieId;
  final int cinemaDayTimeSlotId;
  final String bookingDate;
  final String seatNumber;
  final double price;
  final List<CinemaVo> cinemaList;

  PaymentMethodPage(this.movieId, this.cinemaDayTimeSlotId, this.bookingDate,
      this.seatNumber, this.price, this.cinemaList);

  @override
  _PaymentMethodPageState createState() => _PaymentMethodPageState();
}

class _PaymentMethodPageState extends State<PaymentMethodPage> {
  List<SnackVo> comboSetList = [];
  MovieModel mMovieModel = new MovieModelImpl();
  LoginModel mLoginModel = new LoginModelImpl();
  HandleError handleError = new HandleError();

  double price;

  @override
  void initState() {
    super.initState();

    this.price = widget.price;

    // SnackList From Database
    mMovieModel.getSnackListFromDatabase().listen((snackList) {
      setState(() {
        this.comboSetList = snackList;
        this.comboSetList.map((e) => e.quantity = 0).toList();
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
          padding: EdgeInsets.symmetric(vertical: MARGIN_CARD_MEDIUM_2),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(
                  top: MARGIN_MEDIUM_3,
                  left: 0,
                  bottom: 0,
                  right: 0,
                ),
                child: BackButtonView(() => Navigator.pop(context)),
              ),
              SizedBox(height: MARGIN_SMALL),
              ComboSetSectionView(
                comboSetList: this.comboSetList,
                onTapDecrease: (id) => _decreaseSnackCount(id),
                onTapIncrease: (id) => _increaseSnackCount(id),
              ),
              SizedBox(height: MARGIN_LARGE),
              PromoCodeSectionView(),
              SizedBox(height: MARGIN_MEDIUM_2),
              SubTotalSectionView(this.price),
              SizedBox(height: MARGIN_MEDIUM_3),
              PaymentMethodSectionView(),
              SizedBox(height: MARGIN_MEDIUM_2),
              PayButtonSectionView(
                  widget.movieId,
                  widget.cinemaDayTimeSlotId,
                  widget.bookingDate,
                  widget.seatNumber,
                  this.price,
                  this
                      .comboSetList
                      .map((e) => e)
                      .where((snack) => snack.quantity > 0)
                      .toList(),
                  widget.cinemaList),
            ],
          ),
        ),
      ),
    );
  }

  void _decreaseSnackCount(int id) {
    setState(() {
      this.comboSetList.map((snack) {
        if (snack.id == id && snack.quantity > 0) {
          snack.quantity--;
          this.price = this.price - snack.price;
        }
      }).toList();
    });
  }

  void _increaseSnackCount(int id) {
    setState(() {
      this.comboSetList.map((snack) {
        if (snack.id == id) {
          snack.quantity++;
          this.price = this.price + snack.price;
        }
      }).toList();
    });
  }
}

class PayButtonSectionView extends StatelessWidget {
  final int movieId;
  final int cinemaDayTimeSlotId;
  final String bookingDate;
  final String seatNumber;
  final double price;
  final List<SnackVo> comboSetList;
  final List<CinemaVo> cinemaList;

  PayButtonSectionView(this.movieId, this.cinemaDayTimeSlotId, this.bookingDate,
      this.seatNumber, this.price, this.comboSetList, this.cinemaList);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: MARGIN_CARD_MEDIUM_2),
      child: MainButtonView(
        () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => PaymentConfirmPage(
                this.movieId,
                this.cinemaDayTimeSlotId,
                this.bookingDate,
                this.seatNumber,
                this.price,
                this.comboSetList,
                this.cinemaList),
          ),
        ),
        "Pay \$${this.price}",
      ),
    );
  }
}

class PaymentMethodSectionView extends StatelessWidget {
  const PaymentMethodSectionView({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: MARGIN_CARD_MEDIUM_2),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Payment Method",
            style: TextStyle(
              fontSize: TEXT_REGULAR_3X,
              color: Colors.black,
              fontWeight: FontWeight.w700,
            ),
          ),
          SizedBox(height: MARGIN_MEDIUM_2),
          PaymentMethodView(
              Icon(
                Icons.credit_card,
                size: MARGIN_LARGE,
                color: LOGIN_TEXT_COLOR,
              ),
              "Card Credit",
              "Visa,master card,JCB"),
          SizedBox(height: MARGIN_MEDIUM_2),
          PaymentMethodView(
              Icon(
                Icons.credit_card,
                size: MARGIN_LARGE,
                color: LOGIN_TEXT_COLOR,
              ),
              "Internet Banking (ATM Card)",
              "Visa,master card,JCB"),
          SizedBox(height: MARGIN_MEDIUM_2),
          PaymentMethodView(
              Icon(
                Icons.account_balance_wallet,
                size: MARGIN_LARGE,
                color: LOGIN_TEXT_COLOR,
              ),
              "E-wallet",
              "Paypal"),
        ],
      ),
    );
  }
}

class SubTotalSectionView extends StatelessWidget {
  final double price;

  SubTotalSectionView(this.price);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: MARGIN_CARD_MEDIUM_2),
      child: Text(
        "Sub Total: ${this.price}\$",
        style: TextStyle(
          fontSize: TEXT_REGULAR_2X,
          color: PAYMENT_AMOUNT_TEXT_COLOR,
        ),
      ),
    );
  }
}

class PromoCodeSectionView extends StatelessWidget {
  const PromoCodeSectionView({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: MARGIN_CARD_MEDIUM_2),
      child: Column(
        children: [
          TextField(
            decoration: InputDecoration(
              filled: true,
              fillColor: LOGIN_PAGE_BACKGROUND_COLOR,
              hintText: "Enter Promo Code",
              hintStyle: TextStyle(
                color: LOGIN_TEXT_COLOR,
                fontSize: TEXT_REGULAR_2X,
              ),
            ),
            style: TextStyle(
              color: LOGIN_TEXT_COLOR,
            ),
          ),
          SizedBox(height: MARGIN_MEDIUM),
          Container(
            child: Row(
              children: [
                Text(
                  "Don't have any promo code?",
                  style: TextStyle(
                    fontSize: TEXT_REGULAR_2X,
                    color: LOGIN_TEXT_COLOR,
                  ),
                ),
                SizedBox(width: MARGIN_SMALL),
                Text(
                  "Get it now",
                  style: TextStyle(
                    fontSize: TEXT_REGULAR_2X,
                    color: Colors.black,
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class ComboSetSectionView extends StatelessWidget {
  final List<SnackVo> comboSetList;
  final Function(int) onTapDecrease;
  final Function(int) onTapIncrease;

  ComboSetSectionView(
      {this.comboSetList, this.onTapDecrease, this.onTapIncrease});

  @override
  Widget build(BuildContext context) {
    return Container(
        height: PAYMENT_METHOD_COMBO_SET_HEIGHT,
        child: ListView.builder(
          physics: NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          scrollDirection: Axis.vertical,
          itemCount: 3,
          itemBuilder: (BuildContext context, int index) {
            return Container(
              child: Column(
                children: [
                  ComboSetView(
                    comboSet: this.comboSetList[index],
                    onTapDecrease: (id) => this.onTapDecrease(id),
                    onTapIncrease: (id) => this.onTapIncrease(id),
                  ),
                  SizedBox(height: MARGIN_MEDIUM_3),
                ],
              ),
            );
          },
        ));
  }
}

class PaymentMethodView extends StatelessWidget {
  final Icon paymentIcon;
  final String cardName;
  final String cardType;

  PaymentMethodView(this.paymentIcon, this.cardName, this.cardType);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: [
          paymentIcon,
          SizedBox(width: MARGIN_MEDIUM),
          Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  cardName,
                  style: TextStyle(
                    fontSize: TEXT_REGULAR_2X,
                    color: Colors.black,
                  ),
                ),
                Text(
                  cardType,
                  style: TextStyle(
                    fontSize: TEXT_REGULAR_2X,
                    color: LOGIN_TEXT_COLOR,
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class ComboSetView extends StatelessWidget {
  final SnackVo comboSet;
  final Function(int) onTapDecrease;
  final Function(int) onTapIncrease;

  ComboSetView({this.comboSet, this.onTapDecrease, this.onTapIncrease});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: MARGIN_CARD_MEDIUM_2),
      child: Column(
        children: [
          Row(
            children: [
              Text(
                this.comboSet.name,
                style: TextStyle(
                  fontSize: TEXT_REGULAR_3X,
                  fontWeight: FontWeight.w400,
                ),
              ),
              Spacer(),
              Padding(
                padding: const EdgeInsets.only(
                  top: 0,
                  left: 0,
                  bottom: 0,
                  right: MARGIN_XXLARGE,
                ),
                child: Text(
                  "${this.comboSet.price}\$",
                  style: TextStyle(
                    fontSize: TEXT_REGULAR_3X,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: MARGIN_MEDIUM),
          Row(
            children: [
              Container(
                width: MediaQuery.of(context).size.width * 0.6,
                child: Expanded(
                  child: Text(
                    this.comboSet.description,
                    style: TextStyle(
                      fontSize: TEXT_REGULAR_X,
                      fontWeight: FontWeight.w400,
                      color: LOGIN_TEXT_COLOR,
                      height: TEXT_LINE_HEIGHT,
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black),
                  ),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          IconButton(
                            onPressed: () {
                              this.onTapDecrease(this.comboSet.id);
                            },
                            icon: Icon(
                              Icons.remove,
                            ),
                          ),
                          Spacer(),
                          Container(
                            child:
                                Text((this.comboSet.quantity ?? 0).toString()),
                          ),
                          Spacer(),
                          IconButton(
                            onPressed: () {
                              this.onTapIncrease(this.comboSet.id);
                            },
                            icon: Icon(
                              Icons.add,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
