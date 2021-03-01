import 'package:flutter/material.dart';

class FieldText extends StatelessWidget {
  FieldText(this.text);
  final String text;
  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(fontSize: 20, fontWeight: FontWeight.w300),
    );
  }
}
