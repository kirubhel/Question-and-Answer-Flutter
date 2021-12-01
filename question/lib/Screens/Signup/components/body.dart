import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:question/Screens/Login/login_screen.dart';
import 'package:question/Screens/Signup/components/background.dart';
import 'package:question/Screens/Signup/components/or_divider.dart';
import 'package:question/Screens/Signup/components/social_icon.dart';
import 'package:question/Screens/Signup/signup_screen.dart';
import 'package:question/components/already_have_an_account_acheck.dart';
import 'package:question/components/rounded_button.dart';
import 'package:question/components/rounded_input_field.dart';
import 'package:question/components/rounded_password_field.dart';
import 'package:flutter_svg/svg.dart';
import 'package:question/util/databaseHelper.dart';
import 'package:question/models/userModel.dart';

class Body extends StatelessWidget {
  Databasehelper? _dbHelper = Databasehelper.instance;
  User _user = new User();
  String? _userName;
  String? _email;
  String? _password;
  String? _confirmPassword;
  bool isSignedUp = false;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Background(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              "SIGNUP",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: size.height * 0.03),
            SvgPicture.asset(
              "assets/icons/signup.svg",
              height: size.height * 0.35,
            ),
            RoundedInputField(
              hintText: "User Name",
              onChanged: (value) {
                _userName = value;
              },
            ),
            RoundedInputField(
              hintText: "Your Email",
              onChanged: (value) {
                _email = value;
              },
            ),
            RoundedPasswordField(
              label: 'Password',
              onChanged: (value) {
                _password = value;
              },
            ),
            RoundedPasswordField(
              label: 'Confirm Password',
              onChanged: (value) {
                _confirmPassword = value;
              },
            ),
            RoundedButton(
              text: "SIGNUP",
              press: () {
                var c = _onSubmit();

                showDialog(
                  context: context,
                  barrierDismissible: false, // user must tap button!

                  builder: (BuildContext context) {
                    return new AlertDialog(
                      title: new Text('Sign Up Status'),
                      content: new SingleChildScrollView(
                        child: new ListBody(
                          children: [
                            new Text(c == 2
                                ? 'You have successfully SignedUp'
                                : c == 0
                                    ? 'password dont match'
                                    : c == 4
                                        ? 'password must be at least 8 character'
                                        : 'an error has occured'),
                          ],
                        ),
                      ),
                      actions: [
                        new TextButton(
                          child: new Text('Ok'),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) {
                                  return c == 2
                                      ? LoginScreen()
                                      : SignUpScreen();
                                },
                              ),
                            );
                          },
                        ),
                      ],
                    );
                  },
                );
              },
            ),
            SizedBox(height: size.height * 0.03),
            AlreadyHaveAnAccountCheck(
              login: false,
              press: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return LoginScreen();
                    },
                  ),
                );
              },
            ),
            OrDivider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SocalIcon(
                  iconSrc: "assets/icons/facebook.svg",
                  press: () {},
                ),
                SocalIcon(
                  iconSrc: "assets/icons/twitter.svg",
                  press: () {},
                ),
                SocalIcon(
                  iconSrc: "assets/icons/google-plus.svg",
                  press: () {},
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  int _onSubmit() {
    int? f = _password?.length;
    if (_password != _confirmPassword) {
      return 0;
    } else if (f! < 8) {
      return 4;
    } else if (_userName != null && _email != null && _userName != null) {
      _user.userName = _userName;

      _user.email = _email;
      _user.password = _password;
      _user.createdDate = DateTime.now();
      _user.userType = UserType.user;

      //var x = _dbHelper?.insertuser(_user);

      CollectionReference collectionReference =
          FirebaseFirestore.instance.collection('Users');

      collectionReference.add(_user.toMap());

      if (true) {
        return 2;
      } else {
        return 3;
      }
    } else {
      return 1;
    }
  }
}
