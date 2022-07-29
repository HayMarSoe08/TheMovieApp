import 'package:flutter/material.dart';
import 'package:student_movie_app/resources/dimens.dart';

class BackButtonView extends StatelessWidget {
  final Function onTapBack;
  final Color buttonColor;

  BackButtonView(this.onTapBack, {this.buttonColor = Colors.black});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        onTapBack();
      },
      child: Icon(
        Icons.chevron_left,
        size: MARGIN_XLARGE,
        color: buttonColor,
      ),
    );
  }
}