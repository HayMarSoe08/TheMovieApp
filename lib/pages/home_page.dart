import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:student_movie_app/data/models/lgoin_model.dart';
import 'package:student_movie_app/data/models/login_model_impl.dart';
import 'package:student_movie_app/data/vos/userInfo_vo.dart';
import 'package:student_movie_app/pages/movie_home_page.dart';
import 'package:student_movie_app/resources/dimens.dart';
import 'package:student_movie_app/resources/strings.dart';

import 'login_or_registration_page.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  void initState() {
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        color: Colors.blue,
        child: WelcomePageView(() => Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => LoginOrRegistrationPage()))),
      ),
    );
  }
}

class WelcomePageView extends StatelessWidget {
  final Function onTapStartButton;

  WelcomePageView(this.onTapStartButton);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: MediaQuery.of(context).size.height,
          child: Stack(
            children: [
              Positioned.fill(
                child: HomePageImagesView(),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: HomePageTextAndButtonView(() {
                  this.onTapStartButton();
                }),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class HomePageTextAndButtonView extends StatelessWidget {
  final Function onTapStartButton;

  HomePageTextAndButtonView(this.onTapStartButton);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          HOME_SCREEN_WELCOME,
          style: TextStyle(
            color: Colors.white,
            fontSize: TEXT_HEADING_2X,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: MARGIN_MEDIUM),
        Text(
          HOME_SCREEN_HELLO,
          style: TextStyle(
            color: Colors.white,
            fontSize: TEXT_REGULAR_2X,
          ),
        ),
        SizedBox(height: MARGIN_XXXXLARGE),
        Container(
            margin: EdgeInsets.symmetric(horizontal: MARGIN_CARD_MEDIUM_2),
            height: MARGIN_XXLARGE,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(MARGIN_MEDIUM),
              border: Border.all(
                color: Colors.white,
                width: BORDER_WIDTH_SMALL,
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () {
                    onTapStartButton();
                  },
                  child: Text(
                    HOME_SCREEN_BUTTON_TEXT,
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: TEXT_REGULAR_3X,
                    ),
                  ),
                ),
              ],
            )),
        SizedBox(height: MARGIN_LARGE),
      ],
    );
  }
}

class HomePageImagesView extends StatelessWidget {
  const HomePageImagesView({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      HOME_SCREEN_IMAGES,
      fit: BoxFit.cover,
    );
  }
}
