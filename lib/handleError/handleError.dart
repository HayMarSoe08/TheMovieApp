import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:student_movie_app/network/responses/error_response.dart';

class HandleError {
  void handleError(BuildContext context, dynamic error) {
    if (error is DioError) {
      try {
        ErrorResponse errorResponse =
            ErrorResponse.fromJson(error.response.data);

        showErrorAlert(context, message: errorResponse.message);
      } on Error catch (e) {
        showErrorAlert(context, message: error.toString());
      }
    } else {
      showErrorAlert(context, message: error.toString());
    }
  }

  void showErrorAlert(BuildContext context, {String message}) {
    /// Show A dialog with message here
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text("Error"),
          content: new Text(message),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            new FlatButton(
              child: new Text("OK"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
