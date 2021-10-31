import 'package:question/widgets/csubtitle.dart';
import 'package:flutter/material.dart';

class DropDown extends StatelessWidget {
  final Function onItemPressed;
  final List<String> dropDownItems;
  final String label;
  DropDown({required this.onItemPressed, required this.label, required this.dropDownItems});

  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      //elevation: 5,
      style: TextStyle(color: Colors.black),
      items:dropDownItems.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
      hint: SubtitleText(label,),
      onChanged: (String? value) {
          onItemPressed(value);
      },
    );
  }
}