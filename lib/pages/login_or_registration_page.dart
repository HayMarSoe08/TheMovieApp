import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:student_movie_app/data/models/lgoin_model.dart';
import 'package:student_movie_app/data/models/login_model_impl.dart';
import 'package:student_movie_app/data/vos/userInfo_vo.dart';
import 'package:student_movie_app/handleError/handleError.dart';
import 'package:student_movie_app/resources/colors.dart';
import 'package:student_movie_app/resources/dimens.dart';
import 'package:student_movie_app/resources/strings.dart';
import 'package:student_movie_app/widgets/input_label_view.dart';
import 'package:student_movie_app/widgets/input_textfield_view.dart';
import 'package:student_movie_app/widgets/main_button_view.dart';

import 'movie_home_page.dart';

class LoginOrRegistrationPage extends StatefulWidget {
  @override
  _LoginOrRegistrationPageState createState() =>
      _LoginOrRegistrationPageState();
}

class _LoginOrRegistrationPageState extends State<LoginOrRegistrationPage> {
  final List<String> loginTypeList = ["Login", "Register"];

  TextEditingController _name = new TextEditingController();

  TextEditingController _phoneNo = new TextEditingController();

  TextEditingController _email = new TextEditingController();

  TextEditingController _password = new TextEditingController();

  String googleAccessToken;
  String facebookAccessToken;

  LoginModel mLoginModel = LoginModelImpl();

  HandleError handleError = new HandleError();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _name.dispose();
    _phoneNo.dispose();
    _email.dispose();
    _password.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: LOGIN_PAGE_BACKGROUND_COLOR,
      padding: EdgeInsets.only(
        top: MARGIN_LARGE,
        right: MARGIN_CARD_MEDIUM_2,
        left: MARGIN_CARD_MEDIUM_2,
      ),
      child: LoginOrRegisterTabBarView(
          loginTypeList,
          () => _registerFunction(context),
          () => _loginFunction(context),
          () => _registerWithFacebook(context),
          () => _registerWithGoogle(context),
          () => _loginWithFacebook(context),
          () => _loginWithGoogle(context),
          name: this._name,
          phoneNo: this._phoneNo,
          email: this._email,
          password: this._password),
    );
  }

  /// Register With Email
  void _registerFunction(BuildContext context) {
    mLoginModel
        .postRegisterWithEmail(this._name.text, this._email.text,
            this._phoneNo.text, this._password.text,
            googleAccessToken: this.googleAccessToken,
            facebookAccessToken: this.facebookAccessToken)
        .then((registerData) {
      setState(() {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => MovieHomePage()));
      });
    }).catchError((error) {
      handleError.handleError(context, error.toString());
    });
  }

  /// Register With Facebook
  void _registerWithFacebook(BuildContext context) {
    // Facebook SDK
    FacebookLogin facebookSignIn = new FacebookLogin();

    facebookSignIn.logIn(['email']).then((status) {
      this._name.text = status.accessToken.userId;

      print("FacebookAccessToken-------------!" + status.accessToken.token);
      this.facebookAccessToken = status.accessToken.token;
    });

  }

  /// Register With Google
  void _registerWithGoogle(BuildContext context) {
    // Google SDK
    GoogleSignIn _googleSignIn = GoogleSignIn();

    _googleSignIn.signIn().then((googleAccount) {
      this._email.text = googleAccount.email;
      this._name.text = googleAccount.displayName;
      googleAccount.authentication.then((authentication) {
        print("GoogleAccessToken-------------!" + authentication.accessToken);
        this.googleAccessToken = authentication.accessToken;
      });
    });
  }

  /// Login With Email
  void _loginFunction(BuildContext context) {
    mLoginModel
        .postLoginWithEmail(this._email.text, this._password.text)
        .then((loginData) {
      setState(() {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => MovieHomePage()));
      });
    }).catchError((error) {
      handleError.handleError(context, error.toString());
    });
  }

  /// Login With Facebook
  void _loginWithFacebook(BuildContext context) {

    // Facebook SDK



    mLoginModel
        .postLoginWithFacebook(this.facebookAccessToken)
        .then((loginData) {
      setState(() {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => MovieHomePage()));
      });
    }).catchError((error) {
      handleError.handleError(context, error.toString());
    });
  }

  /// Login With Google
  void _loginWithGoogle(BuildContext context) {

    // Google SDK
    GoogleSignIn _googleSignIn = GoogleSignIn();

    _googleSignIn.signIn().then((googleAccount) {
      //this._email.text = googleAccount.email;
      googleAccount.authentication.then((authentication) {
        print("Token-------------!" + authentication.accessToken);
        mLoginModel
            .postLoginWithGoogle(authentication.accessToken)
            .then((loginData) {
          setState(() {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => MovieHomePage()));
          }
          );
        }).catchError((error) {
          handleError.handleError(context, error.toString());
        });
      });
    });


  }
}

class LoginOrRegisterTabBarView extends StatefulWidget {
  final List<String> loginTypeList;
  final Function() onTapRegisterButton;
  final Function() onTapLoginButton;
  final Function() onTapRegisterWithFacebook;
  final Function() onTapRegisterWithGoogle;
  final Function() onTapLoginWithFacebook;
  final Function() onTapLoginWithGoogle;
  TextEditingController name;
  TextEditingController phoneNo;
  TextEditingController email;
  TextEditingController password;

  LoginOrRegisterTabBarView(
      this.loginTypeList,
      this.onTapRegisterButton,
      this.onTapLoginButton,
      this.onTapRegisterWithFacebook,
      this.onTapRegisterWithGoogle,
      this.onTapLoginWithFacebook,
      this.onTapLoginWithGoogle,
      {this.name,
      this.phoneNo,
      this.email,
      this.password});

  @override
  _LoginOrRegisterTabBarViewState createState() =>
      _LoginOrRegisterTabBarViewState(
          loginTypeList,
          onTapRegisterButton,
          onTapLoginButton,
          this.onTapRegisterWithFacebook,
          this.onTapRegisterWithGoogle,
          this.onTapLoginWithFacebook,
          this.onTapLoginWithGoogle,
          name: this.name,
          phoneNo: this.phoneNo,
          email: this.email,
          password: this.password);
}

class _LoginOrRegisterTabBarViewState extends State<LoginOrRegisterTabBarView> {
  final List<String> loginTypeList;
  final Function() onTapRegisterButton;
  final Function() onTapLoginButton;
  final Function() onTapRegisterWithFacebook;
  final Function() onTapRegisterWithGoogle;
  final Function() onTapLoginWithFacebook;
  final Function() onTapLoginWithGoogle;
  TextEditingController name;
  TextEditingController phoneNo;
  TextEditingController email;
  TextEditingController password;

  _LoginOrRegisterTabBarViewState(
      this.loginTypeList,
      this.onTapRegisterButton,
      this.onTapLoginButton,
      this.onTapRegisterWithFacebook,
      this.onTapRegisterWithGoogle,
      this.onTapLoginWithFacebook,
      this.onTapLoginWithGoogle,
      {this.name,
      this.phoneNo,
      this.email,
      this.password});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DefaultTabController(
        length: loginTypeList.length,
        child: NestedScrollView(
          scrollDirection: Axis.vertical,
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget>[
              SliverAppBar(
                automaticallyImplyLeading: false,
                backgroundColor: LOGIN_PAGE_BACKGROUND_COLOR,
                elevation: MARGIN_ZERO,
                centerTitle: false,
                titleSpacing: MARGIN_ZERO,
                title: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      HOME_SCREEN_WELCOME,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: TEXT_HEADING_2X,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    SizedBox(height: MARGIN_SMALL),
                    Text(
                      LOGIN_SCREEN_TO_CONTINUOUS,
                      style: TextStyle(
                        color: LOGIN_TEXT_COLOR,
                        fontSize: TEXT_REGULAR_2X,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
                floating: true,
                pinned: true,
                snap: true,
                forceElevated: innerBoxIsScrolled,
                expandedHeight: LOGIN_TOOLBAR_HEIGHT,
                bottom: TabBar(
                  isScrollable: false,
                  indicatorColor: PRIMARY_COLOR,
                  labelColor: PRIMARY_COLOR,
                  unselectedLabelColor: Colors.black,
                  tabs: loginTypeList
                      .map(
                        (loginType) => Tab(
                          child: Text(
                            loginType,
                            style: TextStyle(
                              fontSize: TEXT_REGULAR_3X,
                            ),
                          ),
                        ),
                      )
                      .toList(),
                ),
              ),
            ];
          },
          body: TabBarView(
            children: [
              SingleChildScrollView(
                child: Container(
                  padding: EdgeInsets.only(
                    top: MARGIN_XXLARGE,
                    bottom: MARGIN_MEDIUM_2,
                  ),
                  color: LOGIN_PAGE_BACKGROUND_COLOR,
                  child: LoginSectionView(
                    () => this.onTapLoginButton(),
                    () => this.onTapLoginWithFacebook(),
                    () => this.onTapLoginWithGoogle(),
                    email: this.email,
                    password: this.password,
                  ),
                ),
              ),
              SingleChildScrollView(
                child: Container(
                  padding: EdgeInsets.only(
                    top: MARGIN_XXLARGE,
                    bottom: MARGIN_MEDIUM_2,
                  ),
                  color: LOGIN_PAGE_BACKGROUND_COLOR,
                  child: RegisterSectionView(
                      () => this.onTapRegisterButton(),
                      this.onTapRegisterWithFacebook,
                      this.onTapRegisterWithGoogle,
                      name: this.name,
                      phoneNo: this.phoneNo,
                      email: this.email,
                      password: this.password),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class LoginSectionView extends StatelessWidget {
  final Function() onTapButton;
  TextEditingController email;
  TextEditingController password;
  final Function() onTapLoginWithFacebook;
  final Function() onTapLoginWithGoogle;

  LoginSectionView(
      this.onTapButton, this.onTapLoginWithFacebook, this.onTapLoginWithGoogle,
      {this.email, this.password});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        EmailAndPasswordSectionView(this.email, this.password),
        SizedBox(height: MARGIN_XXLARGE),
        ForgetPasswordSectionView(),
        SizedBox(height: MARGIN_XLARGE),
        ButtonSectionView(
            () => this.onTapButton(),
            () => this.onTapLoginWithFacebook(),
            () => this.onTapLoginWithGoogle()),
      ],
    );
  }
}

class RegisterSectionView extends StatelessWidget {
  final Function() onTapButton;
  final Function() onTapRegisterWithFacebook;
  final Function() onTapRegisterWithGoogle;
  TextEditingController name;
  TextEditingController phoneNo;
  TextEditingController email;
  TextEditingController password;

  RegisterSectionView(this.onTapButton, this.onTapRegisterWithFacebook,
      this.onTapRegisterWithGoogle,
      {this.name, this.phoneNo, this.email, this.password});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        InputLabelTextView(LOGIN_SCREEN_NAME),
        InputTextFieldView(controllerName: this.name),
        SizedBox(height: MARGIN_XXLARGE),
        InputLabelTextView(LOGIN_SCREEN_PHONE_NO),
        InputTextFieldView(controllerName: this.phoneNo),
        SizedBox(height: MARGIN_XXLARGE),
        EmailAndPasswordSectionView(this.email, this.password),
        SizedBox(height: MARGIN_XLARGE),
        ButtonSectionView(
          () => this.onTapButton(),
          () => this.onTapRegisterWithFacebook(),
          () => this.onTapRegisterWithGoogle(),
        ),
      ],
    );
  }
}

class EmailAndPasswordSectionView extends StatelessWidget {
  final TextEditingController emailController;
  final TextEditingController passwordController;

  EmailAndPasswordSectionView(this.emailController, this.passwordController);
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          InputLabelTextView(LOGIN_SCREEN_EMAIL),
          InputTextFieldView(controllerName: this.emailController),
          SizedBox(height: MARGIN_XXLARGE),
          InputLabelTextView(LOGIN_SCREEN_PASSWORD),
          InputTextFieldView(
              controllerName: this.passwordController, obscureText: true),
        ],
      ),
    );
  }
}

class ButtonSectionView extends StatelessWidget {
  final Function() onTapButton;
  final Function() onTapFacebook;
  final Function() onTapGoogle;

  ButtonSectionView(this.onTapButton, this.onTapFacebook,
      this.onTapGoogle);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          FacebookAndGoogleButtonView(
            LOGIN_SCREEN_LOGIN_WITH_FACEBOOK_BUTTON_TEXT,
            LOGIN_SCREEN_FACEBOOK_IMAGES,
            () => this.onTapFacebook(),
          ),
          SizedBox(height: MARGIN_XLARGE),
          FacebookAndGoogleButtonView(
            LOGIN_SCREEN_LOGIN_WITH_GOOGLE_BUTTON_TEXT,
            LOGIN_SCREEN_GOOGLE_IMAGES,
            () => this.onTapGoogle(),
          ),
          SizedBox(height: MARGIN_XLARGE),
          MainButtonView(
              () => this.onTapButton(), LOGIN_SCREEN_CONFIRM_BUTTON_TEXT),
        ],
      ),
    );
  }
}

class ForgetPasswordSectionView extends StatelessWidget {
  const ForgetPasswordSectionView({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Text(
          LOGIN_SCREEN_FORGET_PASSWORD,
          style: TextStyle(
            color: LOGIN_TEXT_COLOR,
            fontSize: TEXT_REGULAR_2X,
          ),
        ),
      ],
    );
  }
}

class FacebookAndGoogleButtonView extends StatelessWidget {
  final String images;
  final String title;
  final Function() onTapButton;

  FacebookAndGoogleButtonView(this.title, this.images, this.onTapButton);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MARGIN_XXXLARGE,
      decoration: BoxDecoration(
        color: LOGIN_PAGE_BACKGROUND_COLOR,
        borderRadius: BorderRadius.circular(MARGIN_MEDIUM),
        border: Border.all(
          color: Colors.black,
          width: BORDER_WIDTH_SMALL,
        ),
      ),
      child: GestureDetector(
        onTap: () {
          this.onTapButton();
        },
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                images,
                height: MARGIN_XLARGE,
              ),
              SizedBox(width: MARGIN_XLARGE),
              Text(
                title,
                style: TextStyle(
                  color: LOGIN_TEXT_COLOR,
                  fontSize: TEXT_REGULAR_3X,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
