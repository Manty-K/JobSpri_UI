import 'package:flutter/material.dart';

class LabeledRadioButton extends StatefulWidget {
  final Function(dynamic) function;
  final String title;
  final value;
  final groupValue;
  LabeledRadioButton({
    @required this.title,
    @required this.function,
    @required this.value,
    @required this.groupValue,
  });
  @override
  _LabeledRadioButtonState createState() => _LabeledRadioButtonState();
}

class _LabeledRadioButtonState extends State<LabeledRadioButton> {
  @override
  Widget build(BuildContext context) {
    return Row(children: [
      Radio(
        onChanged: widget.function,
        value: widget.value,
        groupValue: widget.groupValue,
      ),
      Text(widget.title),
    ]);
  }
}
