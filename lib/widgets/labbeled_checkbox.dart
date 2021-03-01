import 'package:flutter/material.dart';

class LabeledCheckbox extends StatelessWidget {
  final String title;
  final bool value;
  final Function(bool) function;
  LabeledCheckbox(
      {@required this.title, @required this.value, @required this.function});
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Checkbox(value: value, onChanged: function),
        Text(title),
      ],
    );
  }
}
