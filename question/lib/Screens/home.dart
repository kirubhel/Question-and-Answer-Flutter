import 'package:flutter/material.dart';
import 'package:question/models/userModel.dart';
import 'package:question/util/shared_Refernce.dart';
import 'package:question/constants.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);
  final List<Widget> _widgetOptions = [];
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  SharedPreferencesUtil _preferencesUtil = new SharedPreferencesUtil();

  late String _username;
  late String _email;
  late String _userTpe;

  @override
  Widget build(BuildContext context) {
    _username = _preferencesUtil.getUserName();
    _email = _preferencesUtil.getEmail();
    _userTpe=_preferencesUtil.getUserType();
    return Scaffold(
        drawer: Drawer(
            child: ListView(padding: EdgeInsets.zero, children: [
      Container(
        margin: const EdgeInsets.only(bottom: 8.0),
        child: DrawerHeader(
          decoration: BoxDecoration(
            color: kPrimaryColor,
          ),
          child: Column(
            children: [
              SizedBox.fromSize(
                size: Size.square(72),
                child: CircleAvatar(
                  child: Text(
                    "${_username[0]}",
                    style: TextStyle(fontSize: 40.0),
                  ),
                ),

                //CircleAvatar(child: Text("B", style: TextStyle(fontSize: 40.0),))
              ),
              SizedBox(
                height: 16,
              ),
              Text(_username,
                  style: Theme.of(context)
                      .textTheme
                      .subtitle1!
                      .copyWith(color: Colors.white)),
              SizedBox(
                height: 4,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    _userTpe==UserType.user.toString()?"normal user":"admin",
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(color: Colors.white),
                  ),
                  SizedBox(
                    width: 8,
                  ),
                  Text(
                    "|",
                   
                  ),
                 Text(
                    _email,
                
                  ),
                ],
              )
            ],
          ),
        ),
      )
    ])));
  }
}
