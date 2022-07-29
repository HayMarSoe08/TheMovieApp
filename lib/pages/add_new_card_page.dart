import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:student_movie_app/data/models/lgoin_model.dart';
import 'package:student_movie_app/data/models/login_model_impl.dart';
import 'package:student_movie_app/data/vos/snack_vo.dart';
import 'package:student_movie_app/handleError/handleError.dart';
import 'package:student_movie_app/pages/payment_confirm_page.dart';
import 'package:student_movie_app/resources/colors.dart';
import 'package:student_movie_app/resources/dimens.dart';
import 'package:student_movie_app/resources/strings.dart';
import 'package:student_movie_app/widgets/input_label_view.dart';
import 'package:student_movie_app/widgets/input_textfield_view.dart';
import 'package:student_movie_app/widgets/main_button_view.dart';

class AddNewCardPage extends StatefulWidget {

  @override
  _AddNewCardPageState createState() => _AddNewCardPageState();
}

class _AddNewCardPageState extends State<AddNewCardPage> {
  TextEditingController _cardHolder = new TextEditingController();

  TextEditingController _cardNumber = new TextEditingController();

  TextEditingController _expireDate = new TextEditingController();

  TextEditingController _cvc = new TextEditingController();

  LoginModel mLoginModel = new LoginModelImpl();

  HandleError handleError = new HandleError();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        color: LOGIN_PAGE_BACKGROUND_COLOR,
        padding: EdgeInsets.only(
          top: MARGIN_XXXLARGE,
          left: MARGIN_CARD_MEDIUM_2,
          bottom: MARGIN_CARD_MEDIUM_2,
          right: MARGIN_CARD_MEDIUM_2,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            InputLabelTextView(ADD_NEW_CARD_NUMBER),
            InputTextFieldView(controllerName: this._cardNumber),
            SizedBox(height: MARGIN_MEDIUM_2),
            InputLabelTextView(ADD_NEW_CARD_HOLDER),
            InputTextFieldView(controllerName: this._cardHolder),
            SizedBox(height: MARGIN_MEDIUM_2),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                InputLabelTextView(ADD_NEW_EXPIRATION_DATE),
                SizedBox(width: MARGIN_XXXLARGE + MARGIN_MEDIUM),
                InputLabelTextView(ADD_NEW_CVD),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Expanded(
                  child: TextField(
                    controller: this._expireDate,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                    ),
                    style: TextStyle(
                      color: Colors.black,
                    ),
                  ),
                ),
                SizedBox(width: MARGIN_MEDIUM_2),
                Expanded(
                  child: TextField(
                    controller: this._cvc,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                    ),
                    style: TextStyle(
                      color: Colors.black,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: MARGIN_XXLARGE),
            MainButtonView(
              () => createCard(),
              ADD_NEW_CARD_BUTTON_TEXT,
            ),
          ],
        ),
      ),
    );
  }

  void createCard() {
      mLoginModel
          .postCreateCard(this._cardNumber.text, this._cardHolder.text,
              this._expireDate.text, int.parse(this._cvc.text))
          .then((cardList) {
        Navigator.pop(context);
      }).catchError((error) {
        handleError.handleError(context, error.toString());
      });
  }
}
