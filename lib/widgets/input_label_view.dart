import 'package:flutter/material.dart';
import 'package:student_movie_app/resources/colors.dart';
import 'package:student_movie_app/resources/dimens.dart';

class InputLabelTextView extends StatelessWidget {
  final String text;

  InputLabelTextView(this.text);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        color: LOGIN_TEXT_COLOR,
        fontSize: TEXT_REGULAR_2X,
      ),
    );
  }
}
