import 'package:flutter/material.dart';

class InputTextFieldView extends StatelessWidget {
  final bool obscureText;
  final bool hint;
  final TextEditingController controllerName;

  InputTextFieldView({this.obscureText = false, this.hint = false, this.controllerName});

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: this.controllerName,
      obscureText: obscureText,
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.white,
        //errorText: this.controllerName.text.isEmpty ? 'Value Can\'t Be Empty' : null,
      ),
      style: TextStyle(
        color: Colors.black,
      ),
    );
  }
}
