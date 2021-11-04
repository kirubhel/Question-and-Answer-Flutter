import 'package:flutter/material.dart';
import 'package:question/components/text_field_container.dart';
import 'package:question/constants.dart';

class RoundedInputField extends StatelessWidget {
  final String hintText;
  final int ? minline;
  final int ? maxline;
  final IconData icon;
  final ValueChanged<String> onChanged;
  const RoundedInputField({
    Key? key,
  required  this.hintText,
    this.icon = Icons.person,
    this.minline=1,
     this.maxline=1,
  required  this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFieldContainer(
      child: TextField(
        
      minLines: minline ,
      maxLines:maxline,
        onChanged: onChanged,
        cursorColor: kPrimaryColor,
        decoration: InputDecoration(
          icon: Icon(
            icon,
            color: kPrimaryColor,
          ),
          hintText: hintText,
          border: InputBorder.none,
        ),
      ),
    );
  }
}
