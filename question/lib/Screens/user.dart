import 'package:flutter/material.dart';
import 'package:question/Screens/AdminScreen/UsersList.dart';

import 'package:question/Screens/Login/login_screen.dart';
import 'package:question/Screens/UserScreen/recentExam.dart';
import 'package:question/Screens/UserScreen/takeExam.dart';
import 'package:question/constants.dart';
import 'package:question/util/shared_Refernce.dart';
import 'package:question/widgets/CustomDivider.dart';
class UserPage extends StatefulWidget {
  UserPage({Key? key}) : super(key: key);
 final List<Widget> _widgetOptions = [
    TakeExam(),
    RecentExamPage(),
  
  ];
  @override
  _UserPageState createState() => _UserPageState();
}
class _UserPageState extends State<UserPage> {
   int _currentIndex = 0;
  SharedPreferencesUtil _preferencesUtil = new SharedPreferencesUtil();

  late String _username;
  late String _email;
  late String _userTpe;
  String title = "";
 @override
  Widget build(BuildContext context) {
    _username = _preferencesUtil.getUserName().toUpperCase();
    _email = _preferencesUtil.getEmail().toUpperCase();
    _userTpe = _preferencesUtil.getUserType();

    title = _userTpe == "UserType.admin" ? "Admin Page" : "User Page";
    return Scaffold(
     backgroundColor: kPrimaryLightColor,
      appBar: AppBar(
        centerTitle: true,
        title: Text(title),
        backgroundColor: kPrimaryColor,
      ),
      drawer: Drawer(
        
          child: ListView(
            
            padding: EdgeInsets.zero, children: [
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
                      _userTpe == "UserType.user"
                          ? "user".toUpperCase()
                          : "admin".toUpperCase(),
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(color: Colors.white),
                    ),
                    SizedBox(
                      width: 8,
                    ),
                    Text("|  ", style: TextStyle(color: Colors.white)),
                    Text(_email, style: TextStyle(color: Colors.white)),
                  ],
                )
              ],
            ),
          ),
        ),
        _buildDrawerActionItems(
          context,
          isSelected: _currentIndex == 0,
          onPressed: () => {
            setState(() {
              _currentIndex = 0;
              Navigator.pop(context);
            })
          },
          label: "Take Exam",
          icon: Icons.question_answer_outlined
        ),
        _buildDrawerActionItems(
          context,
          isSelected: _currentIndex == 1,
          onPressed: () => {
            setState(() {
              _currentIndex = 1;
              Navigator.pop(context);
            })
          },
          label: "Recent Exam",
          icon: Icons.question_answer_rounded,
        ),
         CustomDivider(),
            _buildDrawerActionItems(context,onPressed: (){
             Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return LoginScreen();
                    },
                  ),
                );
            },
            label: "Sign Out",
            icon: Icons.logout_outlined,),
          
      ])),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: kPrimaryLightColor,
        fixedColor: kPrimaryColor,
        items: [
          BottomNavigationBarItem(
              label:"Take Exam", icon: Icon(Icons.question_answer_outlined)),
               BottomNavigationBarItem(
              label: "Recent Exam", icon: Icon(Icons.question_answer_rounded)),
        ],
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
            switch (index) {
              case 0:
                title = "Take Exam";
                break;
              case 1:
                title = "Recent Exam";
                break;
           
           
            }
          });
        },
      ),
      body: widget._widgetOptions.elementAt(_currentIndex),
  
         
         
         );
            
            
            }
            
  Widget _buildDrawerActionItems(
    BuildContext context, {
    isSelected = false,
    required String label,
    required VoidCallback onPressed,
    required IconData icon,
  }) {
    var theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
      child: Row(
        children: [
          Icon(
            icon,
            color: isSelected ? theme.primaryColor : null,
          ),
          SizedBox(
            width: 16,
          ),
          GestureDetector(
              onTap: onPressed,
              child: Text(
                label,
                style: isSelected
                    ? theme.textTheme.button!
                        .copyWith(color: theme.primaryColor)
                    : theme.textTheme.button!
                        .copyWith(fontWeight: FontWeight.normal),
              )),
        ],
      ),
    );
  }

}