import 'package:flutter/material.dart';

class SubtitleText extends StatelessWidget {
  final bool isBold;
  final String text;
  SubtitleText(this.text, {this.isBold = false, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(this.text, style: isBold ?Theme.of(context).textTheme.subtitle2 : Theme.of(context).textTheme.subtitle1,);
  }
}
