

import 'package:flutter/material.dart';
import 'package:question/components/text_field_container.dart';
import 'package:question/constants.dart';

class RoundedPasswordField extends StatefulWidget {
 
 const RoundedPasswordField({
    Key? key,
   required this.onChanged ,
    this.label,
  }) : super(key: key);

  final ValueChanged<String> onChanged;
  final String? label;
  @override
  State<RoundedPasswordField> createState() =>_roundedPasswordField();

}
class _roundedPasswordField extends State<RoundedPasswordField> {
 
  
  late bool _passwordVisible;
@override
  void initState() {
    _passwordVisible = false;
  }
  @override
  Widget build(BuildContext context) {
    return TextFieldContainer(
      child: TextField(
        obscureText: _passwordVisible,
        onChanged: widget.onChanged,
        cursorColor: kPrimaryColor,
        decoration: InputDecoration(
          hintText: widget.label,
          icon: Icon(
            Icons.lock,
            color: kPrimaryColor,
          ),
          suffixIcon: IconButton(
            icon: Icon(
              // Based on passwordVisible state choose the icon
              _passwordVisible ? Icons.visibility : Icons.visibility_off,
              color: Theme.of(context).primaryColorDark,
            ),
            onPressed: () {
              // Update the state i.e. toogle the state of passwordVisible variable
              setState(() {
                   _passwordVisible = !_passwordVisible;
               });
            },
          ),
          border: InputBorder.none,
        ),
      ),
    );
  }
}
