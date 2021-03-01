import 'package:flutter/material.dart';

class SectionText extends StatelessWidget {
  final String _text;
  SectionText(this._text);
  @override
  Widget build(BuildContext context) {
    return Text(
      _text,
      style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
    );
  }
}
