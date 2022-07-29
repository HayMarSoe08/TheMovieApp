import 'package:flutter/material.dart';
import 'package:student_movie_app/data/models/lgoin_model.dart';
import 'package:student_movie_app/data/models/login_model_impl.dart';
import 'package:student_movie_app/data/models/movie_model.dart';
import 'package:student_movie_app/data/models/movie_model_impl.dart';
import 'package:student_movie_app/data/vos/movie_vo.dart';
import 'package:student_movie_app/data/vos/userInfo_vo.dart';
import 'package:student_movie_app/handleError/handleError.dart';
import 'package:student_movie_app/network/api_constants.dart';
import 'package:student_movie_app/pages/movie_detail_page.dart';
import 'package:student_movie_app/resources/colors.dart';
import 'package:student_movie_app/resources/dimens.dart';
import 'package:student_movie_app/resources/strings.dart';

import 'login_or_registration_page.dart';

class MovieHomePage extends StatefulWidget {
  @override
  _MovieHomePageState createState() => _MovieHomePageState();
}

class _MovieHomePageState extends State<MovieHomePage> {
  final List<String> menuItems = [
    "Promotion Code",
    "Select Language",
    "Terms of Service",
    "Help",
    "Rate us"
  ];

  LoginModel mLoginModel = new LoginModelImpl();
  MovieModel mMovieModel = new MovieModelImpl();
  UserInfoVo userInfo;
  List<MovieVo> nowPlayingMovieList;
  List<MovieVo> comingsoonMovieList;

  HandleError handleError = new HandleError();

  @override
  void initState() {
    super.initState();

    /// NetWork
    /// User Profile

    mLoginModel.getProfileFromDatabase().listen((userProfile) {
      setState(() {
        userInfo = userProfile;
      });
    }).onError((error) {
      handleError.handleError(context, error.toString());
    });

    /// Now Playing
    // mMovieModel.getMovieList("nowPlaying").then((data) {
    //   setState(() {
    //     nowPlayingMovieList = data;
    //   });
    // }).catchError((error) {
    //   handleError.handleError(context, error.toString());
    // });
    //
    // /// Coming Soon
    // mMovieModel.getMovieList("comingsoon").then((data) {
    //   setState(() {
    //     comingsoonMovieList = data;
    //   });
    // }).catchError((error) {
    //   handleError.handleError(context, error.toString());
    // });

    /// Database
    /// Now Playing
    mMovieModel.getNowPlayingMovieListFromDatabase().listen((data) {
      setState(() {
        nowPlayingMovieList = data;
      });
    }).onError((error) {
      handleError.handleError(context, error.toString());
    });

    /// Coming Soon
    mMovieModel.getComingSoonMovieListFromDatabase().listen((data) {
      setState(() {
        comingsoonMovieList = data;
      });
    }).onError((error) {
      handleError.handleError(context, error.toString());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: LOGIN_PAGE_BACKGROUND_COLOR,
        elevation: 0.0,
        actions: [
          Padding(
            padding: const EdgeInsets.only(
              top: 0,
              left: 0,
              bottom: 0,
              right: MARGIN_MEDIUM_2,
            ),
            child: Icon(
              Icons.search,
              color: Colors.black,
            ),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          color: LOGIN_PAGE_BACKGROUND_COLOR,
          child: MovieInformationDetailsView(
            (movieId) => Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => MovieDetailPage(movieId))),
            this.nowPlayingMovieList,
            this.comingsoonMovieList,
            this.userInfo,
          ),
        ),
      ),
      drawer: Container(
        width: MediaQuery.of(context).size.width * 0.8,
        child: Drawer(
          elevation: 0,
          child: Container(
            color: PRIMARY_COLOR,
            padding: EdgeInsets.symmetric(horizontal: MARGIN_MEDIUM_2),
            child: Column(
              children: [
                SizedBox(height: MARGIN_XXX_LARGE),
                DrawerHeaderSectionView(this.userInfo),
                SizedBox(height: MARGIN_XXLARGE),
                Column(
                  children: menuItems
                      .map(
                        (menu) => Container(
                          margin: EdgeInsets.only(top: MARGIN_MEDIUM_2),
                          child: ListTile(
                            leading: Icon(
                              Icons.help,
                              color: Colors.white,
                            ),
                            title: Text(
                              menu,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: TEXT_REGULAR_3X,
                              ),
                            ),
                          ),
                        ),
                      )
                      .toList(),
                ),
                Spacer(),
                LogoutSectionView(
                  () => logoutFunction(context),
                ),
                SizedBox(height: MARGIN_XLARGE),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void logoutFunction(BuildContext context) {
    mLoginModel.logout().then((data) {
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => LoginOrRegistrationPage()));
    }).catchError((error) {
      handleError.handleError(context, error.toString());

    });
  }
}

class DrawerHeaderSectionView extends StatelessWidget {
  final UserInfoVo mUserInfo;

  DrawerHeaderSectionView(this.mUserInfo);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: PROFILE_IMAGE_SIZE,
          height: PROFILE_IMAGE_SIZE,
          decoration: BoxDecoration(
              shape: BoxShape.circle,
              image: DecorationImage(
                fit: BoxFit.cover,
                image: NetworkImage(
                  "$BASE_URL_DIO${this.mUserInfo.profile_image}",
                ),
              )),
        ),
        SizedBox(width: MARGIN_MEDIUM_2),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              this.mUserInfo.name,
              style: TextStyle(
                color: Colors.white,
                fontSize: TEXT_REGULAR_3X,
                fontWeight: FontWeight.w700,
              ),
            ),
            SizedBox(height: MARGIN_MEDIUM),
            Row(
              children: [
                Text(
                  this.mUserInfo.email,
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
                SizedBox(width: MARGIN_LARGE),
                Text(
                  "Edit",
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ],
        )
      ],
    );
  }
}

class LogoutSectionView extends StatelessWidget {
  final Function onTapLogout;

  LogoutSectionView(this.onTapLogout);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => this.onTapLogout(),
      child: ListTile(
        leading: Icon(
          Icons.logout,
          color: Colors.white,
        ),
        title: Text(
          "Log out",
          style: TextStyle(
            color: Colors.white,
            fontSize: TEXT_REGULAR_3X,
          ),
        ),
      ),
    );
  }
}

class MovieInformationDetailsView extends StatelessWidget {
  final Function(int) onTapMovie;
  final List<MovieVo> nowPlayingMovieList;
  final List<MovieVo> comingsoonMovieList;
  final UserInfoVo mUserInfo;

  MovieInformationDetailsView(this.onTapMovie, this.nowPlayingMovieList,
      this.comingsoonMovieList, this.mUserInfo);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        LoginUserShowView(this.mUserInfo),
        SizedBox(height: MARGIN_MEDIUM),
        MovieStateTitleView(MOVIE_INFO_PAGE_NOW_SHOWING_TEXT),
        SizedBox(height: MARGIN_MEDIUM_2),
        MovieListView(
          (movieId) => this.onTapMovie(movieId),
          mMovieList: this.nowPlayingMovieList,
        ),
        SizedBox(height: MARGIN_MEDIUM),
        MovieStateTitleView(MOVIE_INFO_PAGE_COMING_SOON_TEXT),
        SizedBox(height: MARGIN_MEDIUM_2),
        MovieListView(
          (movieId) => this.onTapMovie(movieId),
          mMovieList: this.comingsoonMovieList,
        ),
      ],
    );
  }
}

class MovieListView extends StatelessWidget {
  final List<MovieVo> mMovieList;
  final Function(int) onTapMovie;

  MovieListView(this.onTapMovie, {this.mMovieList});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MOVIE_LIST_HEIGHT,
      child: (mMovieList != null)
          ? ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: EdgeInsets.only(
                left: MARGIN_MEDIUM_2,
              ),
              itemCount: mMovieList.length,
              itemBuilder: (BuildContext context, int index) {
                return Container(
                  margin: EdgeInsets.only(right: MARGIN_MEDIUM),
                  width: MOVIE_LIST_ITEM_WIDTH,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap: () {
                          onTapMovie(mMovieList[index].id);
                        },
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(MARGIN_MEDIUM),
                          child: Image.network(
                            "$IMAGE_BASE_URL${mMovieList[index].posterPath}",
                            height: MOVIE_IMAGE_HEIGHT,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      SizedBox(height: MARGIN_MEDIUM),
                      Text(
                        mMovieList[index].originalTitle,
                        style: TextStyle(
                          fontSize: TEXT_REGULAR_X,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(height: MARGIN_SMALL),
                      Text(
                        mMovieList[index].genres.map((e) => e).first,
                        style: TextStyle(
                          fontSize: TEXT_SMALL,
                          color: LOGIN_TEXT_COLOR,
                        ),
                      ),
                    ],
                  ),
                );
              },
            )
          : CircularProgressIndicator(),
    );
  }
}

class MovieStateTitleView extends StatelessWidget {
  final String movieState;

  MovieStateTitleView(this.movieState);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: MARGIN_CARD_MEDIUM_2),
      child: Text(
        movieState,
        style: TextStyle(
          fontSize: TEXT_REGULAR_2X,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}

class LoginUserShowView extends StatelessWidget {
  final UserInfoVo mUserInfo;

  LoginUserShowView(this.mUserInfo);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: MARGIN_CARD_MEDIUM_2),
      child: Row(
        children: [
          CircleAvatar(
            backgroundImage:
                NetworkImage("$BASE_URL_DIO${this.mUserInfo?.profile_image}"),
          ),
          SizedBox(width: MARGIN_MEDIUM_2),
          Text(
            this.mUserInfo?.name,
            style: TextStyle(
              fontSize: TEXT_REGULAR_3X,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }
}
