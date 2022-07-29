import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:student_movie_app/data/models/movie_model.dart';
import 'package:student_movie_app/data/models/movie_model_impl.dart';
import 'package:student_movie_app/data/vos/cast_vo.dart';
import 'package:student_movie_app/data/vos/movie_vo.dart';
import 'package:student_movie_app/handleError/handleError.dart';
import 'package:student_movie_app/network/api_constants.dart';
import 'package:student_movie_app/pages/movie_choose_time_page.dart';
import 'package:student_movie_app/resources/colors.dart';
import 'package:student_movie_app/resources/dimens.dart';
import 'package:student_movie_app/resources/strings.dart';
import 'package:student_movie_app/widgets/back_button_view.dart';
import 'package:student_movie_app/widgets/main_button_view.dart';

class MovieDetailPage extends StatefulWidget {
  final int movieId;

  MovieDetailPage(this.movieId);

  @override
  _MovieDetailPageState createState() => _MovieDetailPageState();
}

class _MovieDetailPageState extends State<MovieDetailPage> {
  MovieModel mMovieModel = new MovieModelImpl();
  MovieVo mMovie;
  List<CastVo> mActorList;

  HandleError handleError = new HandleError();

  @override
  void initState() {
    super.initState();

    // Network
    // mMovieModel.getMovieDetails(widget.movieId).then((movie) {
    //   setState(() {
    //     this.mMovie = movie;
    //     this.mActorList = movie.casts.where((cast) => cast.isActor()).toList();
    //   });
    // }).catchError((error) {
    //   handleError.handleError(context, error.toString());
    // });

    // Database
    // MovieDetails
    mMovieModel.getMovieDetailsFromDatabase(widget.movieId).listen((movie) {
      setState(() {
        this.mMovie = movie;
      });
    }).onError((error) {
      handleError.handleError(context, error.toString());
    });

    // CastList
    mMovieModel.getAllCastFromDatabase().listen((castsList) {
      setState(() {
        this.mActorList = castsList;
      });
    }).onError((error) {
      handleError.handleError(context, error.toString());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: LOGIN_PAGE_BACKGROUND_COLOR,
        child: Stack(
          children: [
            Positioned.fill(
              child: CustomScrollView(
                slivers: [
                  MovieImageSliverAppBarView(() => Navigator.pop(context),
                      mMovieVo: this.mMovie),
                  SliverList(
                    delegate: SliverChildListDelegate([
                      MoviePlotView(
                          mMovieVo: this.mMovie, mActorList: this.mActorList),
                    ]),
                  ),
                ],
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: GetTicketButtonSectionView(() => Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          MovieChooseTimePage(widget.movieId)))),
            )
          ],
        ),
      ),
    );
  }
}

class MovieImageSliverAppBarView extends StatelessWidget {
  final Function onTapBack;
  MovieVo mMovieVo;

  MovieImageSliverAppBarView(this.onTapBack, {this.mMovieVo});

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      automaticallyImplyLeading: false,
      expandedHeight: MOVIE_DETAIL_IMAGE_HEIGHT,
      flexibleSpace: Stack(
        children: [
          FlexibleSpaceBar(
            collapseMode: CollapseMode.parallax,
            background: Stack(
              children: [
                Positioned.fill(
                  child: Image.network(
                    "$IMAGE_BASE_URL${mMovieVo?.posterPath}",
                    fit: BoxFit.cover,
                  ),
                ),
                Align(
                  alignment: Alignment.topLeft,
                  child: Padding(
                    padding: EdgeInsets.only(
                      top: MARGIN_XLARGE,
                      left: 0,
                      bottom: 0,
                      right: 0,
                    ),
                    child: BackButtonView(this.onTapBack,
                        buttonColor: Colors.white),
                  ),
                ),
                Align(
                  alignment: Alignment.center,
                  child: Icon(
                    Icons.play_circle_outline_outlined,
                    size: MARGIN_XXXLARGE,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: MARGIN_MEDIUM_3,
              decoration: BoxDecoration(
                color: LOGIN_PAGE_BACKGROUND_COLOR,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(MARGIN_XXXLARGE),
                  topRight: Radius.circular(MARGIN_XXXLARGE),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class MoviePlotView extends StatelessWidget {
  MovieVo mMovieVo;
  List<CastVo> mActorList;

  MoviePlotView({this.mMovieVo, this.mActorList});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MOVIE_DETAIL_PLOT_WIDTH,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          MovieTitleView(mMovieVo: this.mMovieVo),
          SizedBox(height: MARGIN_MEDIUM),
          ChipButtonView(mMovieVo),
          SizedBox(height: MARGIN_MEDIUM_2),
          PlotSummaryView(mMovieVo: this.mMovieVo),
          SizedBox(height: MARGIN_MEDIUM_2),
          CastListView(mActorList: this.mActorList),
          SizedBox(height: MARGIN_XXXXLARGE),
        ],
      ),
    );
  }
}

class GetTicketButtonSectionView extends StatelessWidget {
  final Function onTapButton;

  const GetTicketButtonSectionView(this.onTapButton);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(MARGIN_CARD_MEDIUM_2),
      child: MainButtonView(
        this.onTapButton,
        MOVIE_DETAIL_PAGE_GET_TICKET_BUTTON_TEXT,
      ),
    );
  }
}

class CastListView extends StatelessWidget {
  final List<CastVo> mActorList;

  CastListView({this.mActorList});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Row(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: MARGIN_CARD_MEDIUM_2),
                child: Text(
                  "Cast",
                  style: TextStyle(
                    fontSize: TEXT_HEADING_1X,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: MARGIN_MEDIUM_2),
          MovieMainCastView(mActorList: this.mActorList),
        ],
      ),
    );
  }
}

class PlotSummaryView extends StatelessWidget {
  final MovieVo mMovieVo;

  PlotSummaryView({this.mMovieVo});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: MARGIN_CARD_MEDIUM_2),
      child: Column(
        children: [
          Row(
            children: [
              Text(
                "Plot Summary",
                style: TextStyle(
                  fontSize: TEXT_HEADING_1X,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          SizedBox(height: MARGIN_MEDIUM),
          Row(
            children: [
              Expanded(
                child: Text(
                  mMovieVo?.overview,
                  style: TextStyle(
                    fontSize: TEXT_REGULAR_2X,
                    height: TEXT_LINE_HEIGHT,
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

class ChipButtonView extends StatelessWidget {
  final MovieVo mMovieVo;

  ChipButtonView(this.mMovieVo);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: MARGIN_CARD_MEDIUM_2),
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [MovieDetailPageChipView(genreList: mMovieVo.genres)]),
    );
  }
}

class MovieTitleView extends StatelessWidget {
  final MovieVo mMovieVo;

  MovieTitleView({this.mMovieVo});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: MARGIN_CARD_MEDIUM_2),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            mMovieVo?.originalTitle,
            style: TextStyle(
              fontSize: TEXT_HEADING_2X,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: MARGIN_MEDIUM),
          Row(
            children: [
              Text(
                getTimeString(mMovieVo?.runtime),
                style: TextStyle(
                  fontSize: TEXT_REGULAR_X,
                ),
              ),
              SizedBox(width: MARGIN_MEDIUM),
              RatingBar.builder(
                initialRating: 5.0,
                itemBuilder: (BuildContext context, int index) => Icon(
                  Icons.star,
                  color: Colors.amber,
                ),
                itemSize: MARGIN_MEDIUM_3,
              ),
              SizedBox(width: MARGIN_MEDIUM),
              Text(
                "IMDb ${mMovieVo?.rating}",
                style: TextStyle(
                  fontSize: TEXT_REGULAR_X,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  String getTimeString(int value) {
    final int hour = value ~/ 60;
    final int minutes = value % 60;
    return '${hour.toString().padLeft(2, "0")}:${minutes.toString().padLeft(2, "0")}';
  }
}

class MovieMainCastView extends StatelessWidget {
  final List<CastVo> mActorList;

  MovieMainCastView({this.mActorList});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MOVIE_DETAIL_CAST_VIEW_HEIGHT,
      child: (mActorList != null && mActorList.isNotEmpty)
          ? ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: mActorList.length,
              itemBuilder: (BuildContext context, int index) {
                return Container(
                  width: MOVIE_DETAIL_CAST_ITEM_WIDTH,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CircleAvatar(
                        backgroundImage: NetworkImage(
                            "$IMAGE_BASE_URL${mActorList[index].profilePath}"),
                        maxRadius: MARGIN_XLARGE,
                      )
                    ],
                  ),
                );
              })
          : CircularProgressIndicator(),
    );
  }
}

class MovieDetailPageChipView extends StatelessWidget {
  final List<String> genreList;

  MovieDetailPageChipView({this.genreList});

  @override
  Widget build(BuildContext context) {
    return Wrap(
      alignment: WrapAlignment.start,
      crossAxisAlignment: WrapCrossAlignment.center,
      direction: Axis.horizontal,
      children: _createMovieGenreWidget(),
    );
  }

  List<Widget> _createMovieGenreWidget() {
    List<Widget> widgets = [];
    widgets.addAll(genreList.map((genre) => GenreChipView(genre)).toList());
    widgets.add(
      Icon(
        Icons.favorite_border,
        color: Colors.white,
      ),
    );
    return widgets;
  }
}

class GenreChipView extends StatelessWidget {
  final String buttonText;

  GenreChipView(this.buttonText);
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Chip(
          backgroundColor: LOGIN_PAGE_BACKGROUND_COLOR,
          padding: EdgeInsets.only(
              top: MARGIN_MEDIUM_2,
              left: MARGIN_MEDIUM,
              bottom: MARGIN_MEDIUM_2,
              right: MARGIN_MEDIUM),
          shape: StadiumBorder(side: BorderSide(color: LOGIN_TEXT_COLOR)),
          label: Text(
            buttonText,
            style: TextStyle(
              fontSize: TEXT_REGULAR_X,
            ),
          ),
        ),
        SizedBox(width: MARGIN_MEDIUM),
      ],
    );
  }
}
