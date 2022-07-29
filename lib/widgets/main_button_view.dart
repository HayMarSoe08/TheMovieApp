import 'package:flutter/material.dart';
import 'package:student_movie_app/resources/colors.dart';
import 'package:student_movie_app/resources/dimens.dart';
import 'package:student_movie_app/resources/strings.dart';

class MainButtonView extends StatelessWidget {
  final Function() onTapConfirm;
  final String buttonText;

  MainButtonView(this.onTapConfirm, this.buttonText);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MARGIN_XXXLARGE,
      decoration: BoxDecoration(
        color: PRIMARY_COLOR,
        borderRadius: BorderRadius.circular(MARGIN_MEDIUM),
        border: Border.all(
          color: Colors.black,
          width: BORDER_WIDTH_SMALL,
        ),
      ),
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: () {
                onTapConfirm();
              },
              child: Text(
                buttonText,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: TEXT_REGULAR_3X,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}