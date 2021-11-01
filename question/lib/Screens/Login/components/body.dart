import 'package:flutter/material.dart';
import 'package:question/Screens/Login/components/background.dart';
import 'package:question/Screens/Login/login_screen.dart';
import 'package:question/Screens/Signup/signup_screen.dart';
import 'package:question/Screens/user.dart';
import 'package:question/Screens/home.dart';
import 'package:question/components/already_have_an_account_acheck.dart';
import 'package:question/components/rounded_button.dart';
import 'package:question/components/rounded_input_field.dart';
import 'package:question/components/rounded_password_field.dart';
import 'package:flutter_svg/svg.dart';
import 'package:question/models/userModel.dart';
import 'package:question/util/databaseHelper.dart';
import 'package:question/util/shared_Refernce.dart';

class Body extends StatelessWidget {
  Body({
    Key? key,
  }) : super(key: key);

  Databasehelper _dbhelper = Databasehelper.instance;
  String _email = "";
  String _password = "";
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Background(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              "LOGIN",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: size.height * 0.03),
            SvgPicture.asset(
              "assets/icons/login.svg",
              height: size.height * 0.35,
            ),
            SizedBox(height: size.height * 0.03),
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
            RoundedButton(
              text: "LOGIN",
              press: () async {
                int c = await _onSubmit();
                if (c == 2) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return UserPage();
                      },
                    ),
                  );
                } else if (c == 6) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return HomePage();
                      },
                    ),
                  );
                } else {
                  showDialog(
                    context: context,
                    barrierDismissible: false, // user must tap button!

                    builder: (BuildContext context) {
                      return new AlertDialog(
                        title: new Text('Login Status'),
                        content: new SingleChildScrollView(
                          child: new ListBody(
                            children: [
                              new Text(c == 0
                                  ? 'username or password field is empty'
                                  : c == 1
                                      ? 'username or password dosent match'
                                      : 'an error has occured'),
                            ],
                          ),
                        ),
                        actions: [
                          new RoundedButton(
                            text: "ok",
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
                        ],
                      );
                    },
                  );
                }
              },
            ),
            SizedBox(height: size.height * 0.03),
            AlreadyHaveAnAccountCheck(
              press: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return SignUpScreen();
                    },
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Future<int> _onSubmit() async {
    SharedPreferencesUtil _preferencesUtil = new SharedPreferencesUtil();

    SharedPreferencesUtil.initPreference();
    if (_email == "" || _password == "") {
      return 0;
    }

    var x = await _dbhelper.userLogin(_email, _password);
    if (x.isEmpty) {
      return 1;
    }
    if (x[0].userType == UserType.admin) {
      _preferencesUtil.setUserName(x[0].userName);
      _preferencesUtil.setEmail(x[0].email);
      _preferencesUtil.setPassword(x[0].password);
      _preferencesUtil.setUsertype(x[0].userType.toString());
      return 6;
    } else {
      _preferencesUtil.setUserName(x[0].userName);
      _preferencesUtil.setEmail(x[0].email);
      _preferencesUtil.setPassword(x[0].password);
      _preferencesUtil.setUsertype(x[0].userType.toString());
      return 2;
    }
  }
}
